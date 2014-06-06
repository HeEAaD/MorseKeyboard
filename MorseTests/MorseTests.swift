//
//  MorseTests.swift
//  MorseTests
//
//  Created by Steffen on 03.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import XCTest

class MorseTests: XCTestCase {

    var keyboardViewController = KeyboardViewController(nibName: nil, bundle: nil)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testintepretDahDitSequence() {

        XCTAssertEqual(keyboardViewController.intepretDahDitSequence([true,false])!, "A", "\"A\" sequence")

        self.measureBlock() {
            var result = self.keyboardViewController.intepretDahDitSequence([true,false])
        }

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
