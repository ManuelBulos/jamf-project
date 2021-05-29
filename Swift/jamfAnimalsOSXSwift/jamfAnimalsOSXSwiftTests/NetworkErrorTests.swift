//
//  NetworkErrorTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class NetworkErrorTests: XCTestCase {
    func testEqual() {
        let invalidURL = NetworkError.invalidURL
        XCTAssertEqual(invalidURL, NetworkError.invalidURL)
    }

    func testNotEqual() {
        let invalidURL = NetworkError.invalidURL
        let failedToDecodeObject = NetworkError.failedToDecodeObject
        XCTAssertNotEqual(invalidURL, failedToDecodeObject)
    }
}
