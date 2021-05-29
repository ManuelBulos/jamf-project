//
//  EndpointTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class EndpointTests: XCTestCase {
    func testAnimalURL() {
        let animalName = "dog"
        let url = Endpoint.animal(animalName).url
        XCTAssertEqual(url?.scheme, Constants.serverScheme)
        XCTAssertEqual(url?.host, Constants.serverAddress)
        XCTAssertEqual(url?.path, Constants.serverPath)
        XCTAssertEqual(url?.query, "animal=\(animalName)")
    }
}
