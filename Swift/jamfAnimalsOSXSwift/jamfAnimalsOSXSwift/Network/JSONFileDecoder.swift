//
//  JSONFileDecoder.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

struct JSONFileDecoder<T: Codable> {

    enum File: String {
        case animalMockData = "AnimalMockData"
    }

    func decodeFromFile(_ file: File) -> Result<T, NetworkError> {
        if let path = Bundle.main.path(forResource: file.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let object = try JSONDecoder().decode(T.self, from: data)
                return .success(object)
            } catch {
                return .failure(.failedToDecodeObject)
            }
        } else {
            return .failure(.invalidURL)
        }
    }
}
