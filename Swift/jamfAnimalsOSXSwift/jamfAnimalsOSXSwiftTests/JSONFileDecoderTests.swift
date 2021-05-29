//
//  JSONFileDecoderTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class JSONFileDecoderTests: XCTestCase {
    func testValidObject() {
        let jsonFileDecoder = JSONFileDecoder<[Animal]>()
        let result = jsonFileDecoder.decodeFromFile(.animalMockData)

        let success: Bool

        switch result {
        case .success:
            success = true
        case .failure:
            success = false
        }

        XCTAssertTrue(success)
    }

    func testInvalidObject() {
        struct InvalidObjectExample: Codable {
            let foo: String
        }

        let jsonFileDecoder = JSONFileDecoder<InvalidObjectExample>()
        let result = jsonFileDecoder.decodeFromFile(.animalMockData)

        let success: Bool

        switch result {
        case .success:
            success = true
        case .failure:
            success = false
        }

        XCTAssertFalse(success)
    }
}
