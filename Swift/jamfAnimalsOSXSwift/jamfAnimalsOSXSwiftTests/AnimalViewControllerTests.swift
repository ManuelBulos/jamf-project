//
//  AnimalViewControllerTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class AnimalViewControllerTests: XCTestCase {

    let view: AnimalViewController = AnimalViewController.make()

    override func setUp() {
        super.setUp()
        // Triggers viewDidLoad
        _ = view.view
    }

    func testPresenterIsInjected() {
        XCTAssertNotNil(view.presenter)
    }

    func testIfViewConformsToNSTextFieldDelegate() {
        XCTAssertTrue(view.conforms(to: NSTextFieldDelegate.self))
    }

    func testToggleLoadingIndicator() {
        // Show
        view.toggleLoadingIndicator(hidden: false)
        XCTAssertFalse(view.loadingIndicator.isHidden)

        // Hide
        view.toggleLoadingIndicator(hidden: true)
        XCTAssertTrue(view.loadingIndicator.isHidden)
    }

    func testToggleSubmitButton() {
        // Show
        view.toggleSubmitButton(hidden: false)
        XCTAssertFalse(view.submitButton.isHidden)

        // Hide
        view.toggleSubmitButton(hidden: true)
        XCTAssertTrue(view.submitButton.isHidden)
    }

    func testReplaceInputFieldText() {
        // Value
        let valueString = "test string"
        view.replaceInputFieldText(with: valueString)
        XCTAssertEqual(view.animalInputField.stringValue, valueString)

        // Empty
        let emptyString = String()
        view.replaceInputFieldText(with: emptyString)
        XCTAssertEqual(view.animalInputField.stringValue, emptyString)
    }

    func testCleanLabels() {
        view.cleanLabels()
        XCTAssertTrue(view.genusLabel.stringValue.isEmpty)
        XCTAssertTrue(view.foodLabel.stringValue.isEmpty)
        XCTAssertTrue(view.habitatLabel.stringValue.isEmpty)
        XCTAssertTrue(view.soundLabel.stringValue.isEmpty)
    }

    func testShowAnimal() {
        let details = AnimalDetails(genus: "1",
                                    food: "2",
                                    habitat: "3",
                                    sound: "4")
        let animal = Animal(animal: "", details: details)
        view.showAnimal(animal)
        XCTAssertEqual(view.genusLabel.stringValue, "1")
        XCTAssertEqual(view.foodLabel.stringValue, "2")
        XCTAssertEqual(view.habitatLabel.stringValue, "3")
        XCTAssertEqual(view.soundLabel.stringValue, "4")
    }

    func testSubmitButtonPressed() {
        view.submitButtonPressed(view.submitButton as Any)
        XCTAssertFalse(view.submitButton.isHighlighted)
    }

    func testControlTextDidEndEditing() {
        let name = NSControl.textDidEndEditingNotification
        let notification = Notification(name: name, object: nil)
        view.controlTextDidEndEditing(notification)
        XCTAssertFalse(view.animalInputField.isHighlighted)
    }

    func testControlTextDidChange() {
        let name = NSControl.textDidEndEditingNotification
        let notification = Notification(name: name, object: nil)
        view.animalInputField.stringValue = "newValue123"
        view.controlTextDidChange(notification)
        XCTAssertEqual(view.animalInputField.stringValue, "newvalue")
    }
}
