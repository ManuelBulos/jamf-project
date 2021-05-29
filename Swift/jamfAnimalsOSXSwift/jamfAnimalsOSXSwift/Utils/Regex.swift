//
//  Regex.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

struct Regex {

    enum Pattern: String {
        case onlyLetters = "^[a-zA-Z]+$"
    }

    static func charactersMatching(pattern: Pattern, input: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern.rawValue)
            let validCharacters = input.compactMap { (character) -> String? in
                let range = NSRange(location: .zero, length: character.utf16.count)
                let characterIsValid = regex.firstMatch(in: String(character), range: range) != nil
                return characterIsValid ? String(character) : nil
            }
            return validCharacters
        } catch {
            print("Invalid regex pattern", error.localizedDescription)
            return []
        }
    }
}
