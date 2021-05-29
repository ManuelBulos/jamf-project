//
//  NetworkProtocol.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func execute<T: Decodable>(_ endpoint: Endpoint,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
}
