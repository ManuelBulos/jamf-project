//
//  AnimalUITests.swift
//  AnimalUITests
//
//  Created by Jamf on 27.08.2018.
//  Copyright © 2018 Jamf. All rights reserved.
//

import XCTest

class AnimalUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        XCUIApplication().launchArguments = ["uitesting"]
        XCUIApplication().launch()
    }

    func test_01_initial_state() throws {
        let app = XCUIApplication()

        // Focus app
        app.textFields["input"].tap()

        // Only 1 Input should exist
        XCTAssertEqual(app.textFields.count, 1)

        let inputTextfield = app.textFields["input"]

        // Input field is visible
        XCTAssertTrue(inputTextfield.exists)
        // Input field is enabled
        XCTAssertTrue(inputTextfield.isEnabled)
        // Input field is hittable
        XCTAssertTrue(inputTextfield.isHittable)
        // Input field value is empty
        XCTAssertEqual(inputTextfield.value as? String, String())
        // Input field placeholder is not empty
        let placeholder = try XCTUnwrap(inputTextfield.placeholderValue)
        XCTAssertFalse(placeholder.isEmpty)

        // Loading view is hidden
        XCTAssertFalse(app.activityIndicators["loading_indicator"].exists)

        let submitButton = app.buttons["submit"]
        // Submit button is visible
        XCTAssertTrue(submitButton.exists)
        // Submit button is enabled
        XCTAssertTrue(submitButton.isEnabled)
        // Submit button is hittable
        XCTAssertTrue(submitButton.isHittable)

        // Only 8 labels exist + window title
        XCTAssertTrue(app.staticTexts.count == 9)

        // Info labels are not empty
        let genusInfoLabelValue = try XCTUnwrap(app.staticTexts["genus_info_label"].value as? String)
        XCTAssertFalse(genusInfoLabelValue.isEmpty)

        let habitatInfoLabelValue = try XCTUnwrap(app.staticTexts["habitat_info_label"].value as? String)
        XCTAssertFalse(habitatInfoLabelValue.isEmpty)

        let foodInfoLabelValue = try XCTUnwrap(app.staticTexts["food_info_label"].value as? String)
        XCTAssertFalse(foodInfoLabelValue.isEmpty)

        let soundInfoLabelValue = try XCTUnwrap(app.staticTexts["sound_info_label"].value as? String)
        XCTAssertFalse(soundInfoLabelValue.isEmpty)

        // Data labels are empty
        let genusLabelValue = try XCTUnwrap(app.staticTexts["genus_label"].value as? String)
        XCTAssertTrue(genusLabelValue.isEmpty)

        let habitatLabelValue = try XCTUnwrap(app.staticTexts["habitat_label"].value as? String)
        XCTAssertTrue(habitatLabelValue.isEmpty)

        let foodLabelValue = try XCTUnwrap(app.staticTexts["food_label"].value as? String)
        XCTAssertTrue(foodLabelValue.isEmpty)

        let soundLabelValue = try XCTUnwrap(app.staticTexts["sound_label"].value as? String)
        XCTAssertTrue(soundLabelValue.isEmpty)
    }

    func test_02_valid_input() {
        let app = XCUIApplication()

        let input = "dog"
        let expectedResult = "dog"
        let inputField = app.textFields["input"]

        // Input text
        inputField.typeText(input)

        // Input field contains expectedResult
        XCTAssertEqual(inputField.value as? String, expectedResult)
    }

    func test_03_invalid_input() {
        let app = XCUIApplication()

        let input = "1234"
        let expectedResult = ""
        let inputField = app.textFields["input"]

        // Input text
        inputField.typeText(input)

        // Input field contains expectedResult
        XCTAssertEqual(inputField.value as? String, expectedResult)
    }

    func test_04_invalid_and_valid_input() {
        let app = XCUIApplication()

        let input = "ABCD1234+`´ç-.,abcd"
        let expectedResult = "abcdabcd"
        let inputField = app.textFields["input"]

        // Input text
        inputField.typeText(input)

        // Input field contains expectedResult
        XCTAssertEqual(inputField.value as? String, expectedResult)
    }

    func test_05_valid_submission_triggers_error_alert() {
        let app = XCUIApplication()

        // Input text
        app.textFields["input"].typeText("asdf")

        // Submit button tapped
        app.buttons["submit"].tap()

        // Alert is visible
        XCTAssertTrue(app.buttons["OK"].waitForExistence(timeout: 5))
    }

    func test_06_valid_submission_shows_data() throws {
        let app = XCUIApplication()

        // Input text
        app.textFields["input"].typeText("dog")

        // Submit button tapped
        app.buttons["submit"].tap()

        // Wait for data fetch to finish
        XCTAssertTrue(app.buttons["submit"].waitForExistence(timeout: 5))

        // Data labels are not empty
        let genusLabelValue = try XCTUnwrap(app.staticTexts["genus_label"].value as? String)
        XCTAssertFalse(genusLabelValue.isEmpty)

        let habitatLabelValue = try XCTUnwrap(app.staticTexts["habitat_label"].value as? String)
        XCTAssertFalse(habitatLabelValue.isEmpty)

        let foodLabelValue = try XCTUnwrap(app.staticTexts["food_label"].value as? String)
        XCTAssertFalse(foodLabelValue.isEmpty)

        let soundLabelValue = try XCTUnwrap(app.staticTexts["sound_label"].value as? String)
        XCTAssertFalse(soundLabelValue.isEmpty)
    }
}
