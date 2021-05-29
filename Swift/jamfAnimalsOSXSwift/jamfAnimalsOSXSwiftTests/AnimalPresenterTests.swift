//
//  AnimalPresenterTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class AnimalPresenterTests: XCTestCase {

    let presenter: AnimalPresenter = AnimalPresenter(network: NetworkMock(),
                                                     view: AnimalViewController.make())

    func testFetchAnimalSuccess() {
        let expectation = self.expectation(description: "Fetching data from mock network")

        var success: Bool = false

        presenter.fetchAnimal(named: "dog") { result in
            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertTrue(success)
    }

    func testFetchAnimalFailure() {
        let expectation = self.expectation(description: "Fetching data from mock network")

        var success: Bool = false

        presenter.fetchAnimal(named: "") { result in
            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertFalse(success)
    }

    func testGetErrorMessage() {
        // Client error must show "Try searching for something else"
        let searchErrorMessage = presenter.getErrorMessage(error: NetworkError.clientError)
        XCTAssertEqual(searchErrorMessage, "Try searching for something else")

        // Any other errors must contain text
        let otherErrorMessage = presenter.getErrorMessage(error: NetworkError.emptyData)
        XCTAssertNotNil(otherErrorMessage)
    }

    func testIsValidInput() {
        // Valid
        let validInput = "valid input"
        XCTAssertTrue(presenter.isValidInput(validInput))

        // Invalid
        let invalidInput = ""
        XCTAssertFalse(presenter.isValidInput(invalidInput))
    }

    func testRemoveInvalidCharactersFromInput() {
        let input = "ABCD1234+`´ç-.,abcd"
        let expectedResult = "ABCDabcd"
        let result = presenter.removeInvalidCharactersFromInput(input)
        XCTAssertEqual(result, expectedResult)
    }
}
