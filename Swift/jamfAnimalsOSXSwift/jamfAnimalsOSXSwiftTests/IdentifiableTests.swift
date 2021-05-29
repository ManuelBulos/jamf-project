//
//  IdentifiableTests.swift
//  jamfAnimalsOSXSwiftTests
//
//  Created by Manuel on 14/05/21.
//  Copyright © 2021 Jamf. All rights reserved.
//

import XCTest
@testable import jamfAnimalsOSXSwift

class IdentifiableTests: XCTestCase {
    func testTypeName() {
        class SampleFoo: NSObject {}
        XCTAssertEqual(SampleFoo.objectName, "SampleFoo")
    }

    func testInstanceName() {
        class SampleFoo: NSObject {}
        let sampleFoo = SampleFoo()
        XCTAssertEqual(sampleFoo.objectName, "SampleFoo")
    }
}
