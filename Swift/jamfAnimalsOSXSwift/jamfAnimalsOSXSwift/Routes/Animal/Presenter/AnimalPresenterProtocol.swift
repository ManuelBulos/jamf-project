//
//  AnimalPresenterProtocol.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Cocoa

protocol AnimalPresenterProtocol: class {
    init(network: NetworkProtocol, view: AnimalViewProtocol)
    func onViewDidLoad()
    func onSubmit(input: String)
    func onInputChange(input: String)
}
