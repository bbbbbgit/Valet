//  Created by Dan Federman on 1/16/20.
//  Copyright © 2020 Dan Federman.
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

#import <Valet/Valet.h>
#import <XCTest/XCTest.h>

@interface VALValetTests : XCTestCase
@end

@implementation VALValetTests

- (NSString *)identifier;
{
    return @"identifier";
}

- (void)test_valetWithIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet valetWithIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet valetWithIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenPasscodeSetThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithIdentifier:self.identifier accessibility:VALAccessibilityWhenPasscodeSetThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenPasscodeSetThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlockedThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlockedThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlockedThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlockThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlockThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet valetWithIdentifier:@"" accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertNil(valet);
}

- (void)test_iCloudValetWithIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet iCloudValetWithIdentifier:self.identifier accessibility:VALCloudAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet iCloudValetWithIdentifier:self.identifier accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet iCloudValetWithIdentifier:@"" accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertNil(valet);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenPasscodeSetThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenPasscodeSetThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenPasscodeSetThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlockedThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlockedThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlockedThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlockThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlockThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithSharedAccessGroupIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet valetWithSharedAccessGroupIdentifier:@"" accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertNil(valet);
}

- (void)test_iCloudValetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet iCloudValetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALCloudAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet iCloudValetWithSharedAccessGroupIdentifier:self.identifier accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithSharedAccessGroupIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet iCloudValetWithSharedAccessGroupIdentifier:@"" accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertNil(valet);
}

// MARK: Mac Tests

#if TARGET_OS_OSX

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenPasscodeSetThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:self.identifier accessibility:VALAccessibilityWhenPasscodeSetThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenPasscodeSetThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlockedThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlockedThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlockedThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlockThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlockThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetIdentifier:@"" accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertNil(valet);
}

- (void)test_iCloudValetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetIdentifier:self.identifier accessibility:VALCloudAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithExplicitlySetIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetIdentifier:self.identifier accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithExplicitlySetIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetIdentifier:@"" accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertNil(valet);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenPasscodeSetThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenPasscodeSetThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenPasscodeSetThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityWhenUnlockedThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityWhenUnlockedThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlockedThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALAccessibilityAfterFirstUnlockThisDeviceOnly;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertEqual(valet.accessibility, VALAccessibilityAfterFirstUnlockThisDeviceOnly);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_valetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet valetWithExplicitlySetSharedAccessGroupIdentifier:@"" accessibility:VALAccessibilityAfterFirstUnlockThisDeviceOnly];
    XCTAssertNil(valet);
}

- (void)test_iCloudValetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityWhenUnlocked;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALCloudAccessibilityWhenUnlocked];
    XCTAssertEqual(valet.accessibility, VALAccessibilityWhenUnlocked);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsCorrectValet_VALCloudAccessibilityAfterFirstUnlock;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetSharedAccessGroupIdentifier:self.identifier accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertEqual(valet.accessibility, VALCloudAccessibilityAfterFirstUnlock);
    XCTAssertEqual([valet class], [VALValet class]);
}

- (void)test_iCloudValetWithExplicitlySetSharedAccessGroupIdentifier_accessibility_returnsNilWhenIdentifierIsEmpty;
{
    VALValet *const valet = [VALValet iCloudValetWithExplicitlySetSharedAccessGroupIdentifier:@"" accessibility:VALCloudAccessibilityAfterFirstUnlock];
    XCTAssertNil(valet);
}

#endif

@end
