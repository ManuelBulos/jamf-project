//
//  AnimalViewProtocol.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

protocol AnimalViewProtocol: class {
    func toggleLoadingIndicator(hidden: Bool)
    func toggleSubmitButton(hidden: Bool)
    func showError(_ error: NetworkError, message: String)
    func showAnimal(_ animal: Animal)
    func replaceInputFieldText(with newText: String)
    func configureDelegates()
    func cleanLabels()
}
