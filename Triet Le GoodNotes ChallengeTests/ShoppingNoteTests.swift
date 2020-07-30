//
//  ShoppingNoteTests.swift
//  Triet Le GoodNotes ChallengeTests
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import XCTest

class ShoppingNoteTests: XCTestCase {

    func testNormalEqual() {
        let item1 = ShoppingNote<String>("a", 1)
        let item2 = ShoppingNote<String>("a", 2)
        XCTAssertTrue(item1 == item2)
    }

    func testStrongEqual() {
        let item1 = ShoppingNote<String>("a", 1)
        let item2 = ShoppingNote<String>("a", 1)
        XCTAssertTrue(ShoppingNote.equal(lhs: item1, rhs: item2))
    }

    func testNormalNotEqual() {
        let item1 = ShoppingNote<String>("a", 1)
        let item2 = ShoppingNote<String>("b", 2)
        XCTAssertTrue(item1 != item2)
    }

    func testStrongNotEqual() {
        let item1 = ShoppingNote<String>("a", 1)
        let item2 = ShoppingNote<String>("a", 2)
        XCTAssertTrue(ShoppingNote.notEqual(lhs: item1, rhs: item2))
    }

    func testComparable() {
        let item1 = ShoppingNote<String>("a", 2)
        let item2 = ShoppingNote<String>("a", 1)
        XCTAssertTrue(item2 < item1)
    }

}
