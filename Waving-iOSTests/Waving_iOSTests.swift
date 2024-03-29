//
//  Waving_iOSTests.swift
//  Waving-iOSTests
//
//  Created by USER on 2023/05/19.
//

import XCTest
@testable import Waving_iOS

final class Waving_iOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIsValidBirthdate_Valid() {
        let validBirthdate = "1990-12-31"
        XCTAssertTrue(BirthdateFormatter.isValidBirthdate(validBirthdate))
    }
    
    func testIsValidBirthdate_Invalid() {
        let invalidBirthdate = "1990-12-31-Invalid"
        XCTAssertFalse(BirthdateFormatter.isValidBirthdate(invalidBirthdate))
    }

    func testIsValidUsername_Valid() {
        let usernameText = "aa"
        let lengthTest: Bool = !usernameText.isEmpty && usernameText.count > 1 && usernameText.count < 9
        
        let usernameRegex = "^[a-zA-Z가-힣]{2,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let result = usernameTest.evaluate(with: usernameText) && lengthTest
        XCTAssertTrue(result)
    }
    
    func testIsValidUsername_Invalid() {
        let usernameText = "Q"
        let lengthTest: Bool = !usernameText.isEmpty && usernameText.count > 1 && usernameText.count < 9
        
        let usernameRegex = "^[a-zA-Z가-힣]{2,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let result = usernameTest.evaluate(with: usernameText) && lengthTest
        XCTAssertFalse(result)
    }
    
}
