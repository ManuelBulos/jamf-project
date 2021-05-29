//
//  NetworkMockTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class NetworkMockTests: XCTestCase {
    func testSuccessCall() {
        let expectation = self.expectation(description: "Fetching data from network")

        var success: Bool = false

        call(endpoint: Endpoint.animal("dog")) { result in

            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(success)
    }

    func testFailureCall() {
        let expectation = self.expectation(description: "Fetching data from network")

        var success: Bool = false

        call(endpoint: Endpoint.animal("")) { result in

            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(success)
    }

    private func call(endpoint: Endpoint,
                      completion: @escaping (Result<Animal, NetworkError>) -> Void) {
        NetworkMock().execute(endpoint, completion: completion)
    }
}
