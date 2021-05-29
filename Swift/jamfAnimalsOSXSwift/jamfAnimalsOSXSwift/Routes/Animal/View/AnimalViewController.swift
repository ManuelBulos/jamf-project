//
//  AnimalViewController.swift
//  jamfAnimalsOSXSwift
//
//  Created by Jamf on 27.08.2018.
//  Copyright © 2018 Jamf. All rights reserved.
//

import Cocoa

class AnimalViewController: NSViewController {

    static func make() -> AnimalViewController {
        let network: NetworkProtocol

        if CommandLine.arguments.contains("uitesting") {
            network = NetworkMock()
        } else {
            network = Network()
        }

        let storyboard = NSStoryboard(name: "Main", bundle: nil)

        let controller = storyboard.instantiateController(withIdentifier: objectName) as! AnimalViewController

        let presenter = AnimalPresenter(network: network, view: controller)

        controller.presenter = presenter

        return controller
    }

    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet weak var submitButton: NSButton!
    @IBOutlet weak var animalInputField: NSTextField!
    @IBOutlet weak var genusLabel: NSTextField!
    @IBOutlet weak var habitatLabel: NSTextField!
    @IBOutlet weak var foodLabel: NSTextField!
    @IBOutlet weak var soundLabel: NSTextField!

    var presenter: AnimalPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        presenter?.onSubmit(input: animalInputField.stringValue)
    }
}

// MARK: - NSTextFieldDelegate

extension AnimalViewController: NSTextFieldDelegate {
    // On "Return" keystroke hit
    func controlTextDidEndEditing(_ obj: Notification) {
        presenter?.onSubmit(input: animalInputField.stringValue)
    }

    // On Input change
    func controlTextDidChange(_ obj: Notification) {
        presenter?.onInputChange(input: animalInputField.stringValue)
    }
}

// MARK: - AnimalViewControllerProtocol

extension AnimalViewController: AnimalViewProtocol {
    func showError(_ error: NetworkError, message: String) {
        let alert = NSAlert(error: error)
        alert.alertStyle = .informational
        alert.messageText = message
        alert.runModal()
    }

    func showAnimal(_ animal: Animal) {
        let animalDetails = animal.details
        genusLabel.stringValue = animalDetails.genus
        foodLabel.stringValue = animalDetails.food
        habitatLabel.stringValue = animalDetails.habitat
        soundLabel.stringValue = animalDetails.sound
    }

    func replaceInputFieldText(with newText: String) {
        animalInputField.stringValue = newText
    }

    func toggleLoadingIndicator(hidden: Bool) {
        loadingIndicator.isHidden = hidden
    }

    func toggleSubmitButton(hidden: Bool) {
        submitButton.isHidden = hidden
    }

    func configureDelegates() {
        animalInputField.delegate = self
    }

    func cleanLabels() {
        genusLabel.stringValue = String()
        foodLabel.stringValue = String()
        habitatLabel.stringValue = String()
        soundLabel.stringValue = String()
    }
}
