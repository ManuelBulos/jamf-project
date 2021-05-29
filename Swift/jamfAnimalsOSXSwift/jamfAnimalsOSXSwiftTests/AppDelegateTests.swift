//
//  AppDelegateTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class AppDelegateTests: XCTestCase {

    let appDelegate = AppDelegate()

    func testWindow() throws {
        let window = appDelegate.makeWindow(title: Constants.appName,
                                            controller: AnimalViewController.make())

        // Title
        XCTAssertEqual(window.title, Constants.appName)

        // Content ViewController
        let contentViewController = try XCTUnwrap(window.contentViewController)
        XCTAssertTrue(contentViewController.isKind(of: AnimalViewController.self))

        // Style Mask
        XCTAssertEqual(window.styleMask, [.miniaturizable, .closable, .resizable, .titled])

        // BackingStoreType
        XCTAssertEqual(window.backingType, NSWindow.BackingStoreType.buffered)
    }
}
