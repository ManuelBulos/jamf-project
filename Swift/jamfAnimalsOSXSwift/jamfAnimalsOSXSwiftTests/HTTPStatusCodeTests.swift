//
//  HTTPStatusCodeTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class HTTPStatusCodeTests: XCTestCase {
    func testValidCode() {
        let status = HTTPStatusCode(rawValue: 200)
        XCTAssertEqual(status?.responseType, .success)
    }

    func testInvalidCode() {
        let status = HTTPStatusCode(rawValue: 700)
        XCTAssertNil(status?.responseType)
    }

    func testValidHTTPURLResponse() {
        let response = HTTPURLResponse(url: URL(string: "www.example.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        XCTAssertEqual(response?.status, HTTPStatusCode.ok)
    }

    func testInvalidHTTPURLResponse() {
        let response = HTTPURLResponse(url: URL(string: "www.example.com")!,
                                       statusCode: 900,
                                       httpVersion: nil,
                                       headerFields: nil)
        XCTAssertNil(response?.status)
    }

    func testEqualErrorDescriptions() {
        let redirection = HTTPStatusCode(rawValue: 300)
        XCTAssertEqual(redirection?.responseType.errorDescription, HTTPStatusCode(rawValue: 300)?.responseType.errorDescription)
    }

    func testNotEqualErrorDescriptions() {
        let redirection = HTTPStatusCode(rawValue: 300)
        let serverError = HTTPStatusCode(rawValue: 500)
        XCTAssertNotEqual(redirection?.responseType.errorDescription, serverError?.responseType.errorDescription)
    }
}
