//
//  RegexTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class RegexTests: XCTestCase {
    func testOnlyLowercaseLetters() {
        let input = "ABCD1234+`´ç-.,abcd"
        let expectedResult = "ABCDabcd"
        let result = Regex.charactersMatching(pattern: .onlyLetters, input: input).joined()
        XCTAssertEqual(result, expectedResult)
    }
}
