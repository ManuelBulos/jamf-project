//
//  NetworkError.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 13/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidHttpURLResponse
    case httpURLResponseTypeError(HTTPStatusCode.ResponseType)
    case clientError
    case emptyData
    case failedToDecodeObject
    case other(Error)
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is invalid"
        case .invalidHttpURLResponse:
            return "failed to read HTTP URL Response."
        case .httpURLResponseTypeError(let responseType):
            return responseType.localizedDescription
        case .clientError:
            return "Client seems to have erred"
        case .emptyData:
            return "Did not encounter any error, but the data is empty."
        case .failedToDecodeObject:
            return "Failed to decode object from response"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
