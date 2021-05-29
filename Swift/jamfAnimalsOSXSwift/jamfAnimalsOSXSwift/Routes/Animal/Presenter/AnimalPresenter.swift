//
//  AnimalPresenter.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

class AnimalPresenter: AnimalPresenterProtocol {

    private let network: NetworkProtocol

    private weak var view: AnimalViewProtocol?

    required init(network: NetworkProtocol, view: AnimalViewProtocol) {
        self.network = network
        self.view = view
    }

    func onViewDidLoad() {
        view?.configureDelegates()
        view?.cleanLabels()
        view?.toggleSubmitButton(hidden: false)
        view?.toggleLoadingIndicator(hidden: true)
        view?.replaceInputFieldText(with: String())
    }

    func onSubmit(input: String) {
        view?.cleanLabels()

        guard isValidInput(input) else {
            return
        }

        view?.toggleSubmitButton(hidden: true)
        view?.toggleLoadingIndicator(hidden: false)

        fetchAnimal(named: input) { [weak self] result in
            guard let self = self else { return }
            self.view?.toggleSubmitButton(hidden: false)
            self.view?.toggleLoadingIndicator(hidden: true)

            switch result {
            case .success(let animal):
                self.view?.showAnimal(animal)
            case .failure(let error):
                let message = self.getErrorMessage(error: error)
                self.view?.showError(error, message: message)
            }
        }
    }

    func onInputChange(input: String) {
        let validInput = removeInvalidCharactersFromInput(input).lowercased()
        view?.replaceInputFieldText(with: validInput)
    }
}

// MARK: - Business Logic

extension AnimalPresenter {
    internal func fetchAnimal(named animalName: String,
                             completion: @escaping (Result<Animal, NetworkError>) -> Void) {
        network.execute(Endpoint.animal(animalName), completion: completion)
    }

    internal func removeInvalidCharactersFromInput(_ input: String) -> String {
        let validCharacters = Regex.charactersMatching(pattern: .onlyLetters, input: input)
        return validCharacters.joined()
    }

    internal func isValidInput(_ input: String) -> Bool {
        return !input.isEmpty
    }

    internal func getErrorMessage(error: NetworkError) -> String {
        if error == .clientError {
            return "Try searching for something else"
        } else {
            return error.localizedDescription
        }
    }
}
