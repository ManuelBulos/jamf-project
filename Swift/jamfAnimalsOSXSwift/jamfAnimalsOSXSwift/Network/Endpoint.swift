//
//  Endpoint.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 13/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

enum Endpoint {
    typealias AnimalName = String
    case animal(AnimalName)
}

extension Endpoint {
    var url: URL? {

        var components = URLComponents()
        components.scheme = Constants.serverScheme
        components.host = Constants.serverAddress
        components.path = Constants.serverPath

        switch self {
        case .animal(let animalName):
            components.queryItems = [
                URLQueryItem(name: "animal", value: animalName)
            ]
        }

        return components.url

    }
}
