//
//  Identifiable.swift
//  jamfAnimalsOSXSwift
//
//  Created by Manuel on 13/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import Foundation

/// Helper that returns the class name of an object
protocol Identifiable {
    var objectName: String { get }
    static var objectName: String { get }
}

extension Identifiable {
    public var objectName: String {
        return String(describing: type(of: self))
    }

    public static var objectName: String {
        return String(describing: self)
    }
}

extension NSObject: Identifiable {}
