//
//  MorseTests.swift
//  MorseTests
//
//  Created by Steffen on 03.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import XCTest

class MorseTests: XCTestCase {

    var sequenceA : MorseSequence!
    var sequenceB : MorseSequence!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sequenceA = MorseSequence(symbols: [.Dit,.Dah])
        sequenceB = MorseSequence(symbols: [.Dah,.Dit,.Dit,.Dit])

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIntepretMorseSequence() {

        XCTAssertEqual(sequenceA.symbols.count, 2)
        XCTAssertEqual(sequenceA.intepretation!, "A")

        XCTAssertEqual(sequenceB.symbols.count, 4)
        XCTAssertEqual(sequenceB.intepretation!, "B")

    }
    
}
