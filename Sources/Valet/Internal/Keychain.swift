//
//  Keychain.swift
//  Valet
//
//  Created by Dan Federman and Eric Muller on 9/16/17.
//  Copyright © 2017 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation


internal final class Keychain {
    
    // MARK: Private Static Properties
    
    private static let canaryKey = "VAL_KeychainCanaryUsername"
    private static let canaryValue = "VAL_KeychainCanaryPassword"
    
    // MARK: Keychain Accessibility
    
    internal static func canAccess(attributes: [String : AnyHashable]) -> Bool {
        func isCanaryValueInKeychain() -> Bool {
            do {
                let retrievedCanaryValue = try string(forKey: canaryKey, options: attributes)
                return retrievedCanaryValue == canaryValue
                
            } catch {
                return false
            }
        }
        
        if isCanaryValueInKeychain() {
            return true
            
        } else {
            var secItemQuery = attributes
            secItemQuery[kSecAttrAccount as String] = canaryKey
            secItemQuery[kSecValueData as String] = Data(canaryValue.utf8)
            try? SecItem.add(attributes: secItemQuery)
            
            return isCanaryValueInKeychain()
        }
    }
    
    // MARK: Getters
    
    internal static func string(forKey key: String, options: [String : AnyHashable]) throws -> String {
        let data = try object(forKey: key, options: options)
        if let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            throw KeychainError.itemNotFound
        }
    }
    
    internal static func object(forKey key: String, options: [String : AnyHashable]) throws -> Data {
        guard !key.isEmpty else {
            throw KeychainError.emptyKey
        }
        
        var secItemQuery = options
        secItemQuery[kSecAttrAccount as String] = key
        secItemQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        secItemQuery[kSecReturnData as String] = true
        
        return try SecItem.copy(matching: secItemQuery)
    }
    
    // MARK: Setters
    
    internal static func set(string: String, forKey key: String, options: [String: AnyHashable]) throws {
        let data = Data(string.utf8)
        try set(object: data, forKey: key, options: options)
    }
    
    internal static func set(object: Data, forKey key: String, options: [String: AnyHashable]) throws {
        guard !key.isEmpty else {
            throw KeychainError.emptyKey
        }
        
        guard !object.isEmpty else {
            throw KeychainError.emptyValue
        }
        
        var secItemQuery = options
        secItemQuery[kSecAttrAccount as String] = key
        
        #if os(macOS)
            // Never update an existing keychain item on OS X, since the existing item could have unauthorized apps in the Access Control List. Fixes zero-day Keychain vuln found here: https://drive.google.com/file/d/0BxxXk1d3yyuZOFlsdkNMSGswSGs/view
            try? SecItem.deleteItems(matching: secItemQuery)
            secItemQuery[kSecValueData as String] = object
            try SecItem.add(attributes: secItemQuery)
        #else

        if containsObject(forKey: key, options: options) == errSecSuccess {
            try SecItem.update(attributes: [kSecValueData as String: object], forItemsMatching: secItemQuery)
        } else {
            secItemQuery[kSecValueData as String] = object
            try SecItem.add(attributes: secItemQuery)
        }
        #endif
    }
    
    // MARK: Removal
    
    internal static func removeObject(forKey key: String, options: [String : AnyHashable]) throws {
        guard !key.isEmpty else {
            throw KeychainError.emptyKey
        }
        
        var secItemQuery = options
        secItemQuery[kSecAttrAccount as String] = key
        
        try SecItem.deleteItems(matching: secItemQuery)
    }
    
    internal static func removeAllObjects(matching options: [String : AnyHashable]) throws {
        try SecItem.deleteItems(matching: options)
    }
    
    // MARK: Contains
    
    internal static func containsObject(forKey key: String, options: [String : AnyHashable]) -> OSStatus {
        guard !key.isEmpty else {
            return errSecParam
        }
        
        var secItemQuery = options
        secItemQuery[kSecAttrAccount as String] = key
        
        return SecItem.containsObject(matching: secItemQuery)
    }
    
    // MARK: AllObjects
    
    internal static func allKeys(options: [String: AnyHashable]) throws -> Set<String> {
        var secItemQuery = options
        secItemQuery[kSecMatchLimit as String] = kSecMatchLimitAll
        secItemQuery[kSecReturnAttributes as String] = true
        
        let collection: Any = try SecItem.copy(matching: secItemQuery)
        if let singleMatch = collection as? [String : AnyHashable], let singleKey = singleMatch[kSecAttrAccount as String] as? String, singleKey != canaryKey {
            return Set([singleKey])

        } else if let multipleMatches = collection as? [[String: AnyHashable]] {
            return Set(multipleMatches.compactMap({ attributes in
                let key = attributes[kSecAttrAccount as String] as? String
                return key != canaryKey ? key : nil
            }))

        } else {
            return Set()
        }
    }
    
    // MARK: Migration
    
    internal static func migrateObjects(matching query: [String : AnyHashable], into destinationAttributes: [String : AnyHashable], removeOnCompletion: Bool) throws {
        guard query.count > 0 else {
            // Migration requires secItemQuery to contain values.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecMatchLimit as String] as? String as CFString? != kSecMatchLimitOne else {
            // Migration requires kSecMatchLimit to be set to kSecMatchLimitAll.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecReturnData as String] as? Bool != true else {
            // kSecReturnData is not supported in a migration query.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecReturnAttributes as String] as? Bool != false else {
            // Migration requires kSecReturnAttributes to be set to kCFBooleanTrue.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecReturnRef as String] as? Bool != true else {
            // kSecReturnRef is not supported in a migration query.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecReturnPersistentRef as String] as? Bool != false else {
            // Migration requires kSecReturnPersistentRef to be set to kCFBooleanTrue.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecClass as String] as? String as CFString? == kSecClassGenericPassword else {
            // Migration requires kSecClass to be set to kSecClassGenericPassword to avoid data loss.
            throw MigrationError.invalidQuery
        }
        
        guard query[kSecAttrAccessControl as String] == nil else {
            // kSecAttrAccessControl is not supported in a migration query. Keychain items can not be migrated en masse from the Secure Enclave.
            throw MigrationError.invalidQuery
        }
        
        var secItemQuery = query
        secItemQuery[kSecMatchLimit as String] = kSecMatchLimitAll
        secItemQuery[kSecReturnAttributes as String] = true
        secItemQuery[kSecReturnData as String] = false
        secItemQuery[kSecReturnRef as String] = false
        secItemQuery[kSecReturnPersistentRef as String] = true
        
        let collection: Any = try SecItem.copy(matching: secItemQuery)
        let retrievedItemsToMigrate: [[String: AnyHashable]]
        if let singleMatch = collection as? [String : AnyHashable] {
            retrievedItemsToMigrate = [singleMatch]

        } else if let multipleMatches = collection as? [[String: AnyHashable]] {
            retrievedItemsToMigrate = multipleMatches

        } else {
            throw MigrationError.dataInQueryResultInvalid
        }
        
        // Now that we have the persistent refs with attributes, get the data associated with each keychain entry.
        var retrievedItemsToMigrateWithData = [[String : AnyHashable]]()
        for retrievedItem in retrievedItemsToMigrate {
            guard let retrievedPersistentRef = retrievedItem[kSecValuePersistentRef as String] else {
                throw KeychainError.couldNotAccessKeychain

            }
            
            let retrieveDataQuery: [String : AnyHashable] = [
                kSecValuePersistentRef as String : retrievedPersistentRef,
                kSecReturnData as String : true
            ]

            do {
                let data: Data = try SecItem.copy(matching: retrieveDataQuery)
                guard !data.isEmpty else {
                    throw MigrationError.dataInQueryResultInvalid
                }
                
                var retrievedItemToMigrateWithData = retrievedItem
                retrievedItemToMigrateWithData[kSecValueData as String] = data
                retrievedItemsToMigrateWithData.append(retrievedItemToMigrateWithData)
            } catch KeychainError.itemNotFound {
                // It is possible for metadata-only items to exist in the keychain that do not have data associated with them. Ignore this entry.
                continue

            } catch {
                throw error
            }
        }
        
        // Sanity check that we are capable of migrating the data.
        var keysToMigrate = Set<String>()
        for keychainEntry in retrievedItemsToMigrateWithData {
            guard let key = keychainEntry[kSecAttrAccount as String] as? String, key != Keychain.canaryKey else {
                // We don't care about this key. Move along.
                continue
            }
            
            guard !key.isEmpty else {
                throw MigrationError.keyInQueryResultInvalid
            }
            
            guard !keysToMigrate.contains(key) else {
                throw MigrationError.duplicateKeyInQueryResult
            }
            
            guard let data = keychainEntry[kSecValueData as String] as? Data, !data.isEmpty else {
                throw MigrationError.dataInQueryResultInvalid
            }

            if Keychain.containsObject(forKey: key, options: destinationAttributes) == errSecItemNotFound {
                keysToMigrate.insert(key)
            } else {
                throw MigrationError.keyInQueryResultAlreadyExistsInValet
            }
        }
        
        // All looks good. Time to actually migrate.
        var alreadyMigratedKeys = [String]()
        func revertMigration() {
            // Something has gone wrong. Remove all migrated items.
            for alreadyMigratedKey in alreadyMigratedKeys {
                try? Keychain.removeObject(forKey: alreadyMigratedKey, options: destinationAttributes)
            }
        }
        
        for keychainEntry in retrievedItemsToMigrateWithData {
            guard let key = keychainEntry[kSecAttrAccount as String] as? String else {
                revertMigration()
                throw MigrationError.keyInQueryResultInvalid
            }

            guard let value = keychainEntry[kSecValueData as String] as? Data else {
                revertMigration()
                throw MigrationError.dataInQueryResultInvalid
            }

            do {
                try Keychain.set(object: value, forKey: key, options: destinationAttributes)
                alreadyMigratedKeys.append(key)
            } catch {
                revertMigration()
                throw error
            }
        }
        
        // Remove data if requested.
        if removeOnCompletion {
            do {
                try Keychain.removeAllObjects(matching: query)
            } catch {
                revertMigration()
                throw MigrationError.removalFailed
            }

            // We're done!
        }
    }
}
