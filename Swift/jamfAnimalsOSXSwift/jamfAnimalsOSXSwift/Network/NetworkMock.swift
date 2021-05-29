//
//  NetworkMock.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

struct NetworkMock: NetworkProtocol {
    func execute<T: Decodable>(_ endpoint: Endpoint,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard endpoint.url != nil else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        switch endpoint {
        case .animal(let animalName):
            let jsonFileDecoder = JSONFileDecoder<[Animal]>()
            let result = jsonFileDecoder.decodeFromFile(.animalMockData)
            switch result {
            case .success(let animals):
                if let animal = animals.first(where: {$0.animal == animalName}) {
                    guard let animal = animal as? T else {
                        completion(.failure(NetworkError.failedToDecodeObject))
                        return
                    }

                    completion(.success(animal))

                } else {
                    completion(.failure(NetworkError.clientError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
