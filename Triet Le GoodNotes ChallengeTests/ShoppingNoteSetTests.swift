//
//  ShoppingNoteSetTests.swift
//  Triet Le GoodNotes ChallengeTests
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import XCTest

class ShoppingNoteSetTests: XCTestCase {

    func testAdd() {
        let set = ShoppingNoteSet<String>()
        let item = ShoppingNote("Fish", 1)
        set.add(item)
        XCTAssertTrue(set.count == 1)
        XCTAssertTrue(set.isItemAvailable(item))
    }

    func testRemove() {
        let set = ShoppingNoteSet<String>()
        let item = ShoppingNote("Fish", 1)
        set.remove(item)
        XCTAssertTrue(set.count == 0)
        XCTAssertFalse(set.isItemAvailable(item))
    }

    func testEdit() {
        let set = ShoppingNoteSet<String>()
        let item = ShoppingNote("Fish", 1)
        let newItem = ShoppingNote("Fish", 2)
        set.add(item)
        set.add(newItem)
        XCTAssertTrue(set.count == 1)
        XCTAssertFalse(set.isItemAvailable(item))
        XCTAssertTrue(set.isItemAvailable(newItem))
    }

    func testMerge() {
        let set1 = ShoppingNoteSet<String>()
        let set2 = ShoppingNoteSet<String>()

        set1.add(ShoppingNote("Fish", 1))
        set1.add(ShoppingNote("Pork", 11))
        set1.add(ShoppingNote("Cabbage", 1))

        set2.add(ShoppingNote("Cabbage", 22))
        set2.add(ShoppingNote("Green bean", 33))

        set1.merge(set2)

        XCTAssertTrue(set1.count == 4)
        XCTAssertTrue(set1.isItemAvailable(ShoppingNote("Green bean", 33)))
    }

    func testTwoSets() {
        let set1 = ShoppingNoteSet<String>()
        let set2 = ShoppingNoteSet<String>()

        set1.add(ShoppingNote("Fish", 1))
        set1.add(ShoppingNote("Pork", 11))
        set1.add(ShoppingNote("Cabbage", 1))

        set2.add(ShoppingNote("Cabbage", 22))
        set2.add(ShoppingNote("Green bean", 33))

        XCTAssertFalse(set1 == set2)
    }

    func testMergeDuplicate() {
        let set1 = ShoppingNoteSet<String>()
        let set2 = ShoppingNoteSet<String>()

        set1.add(ShoppingNote("Fish", 1))
        set2.add(ShoppingNote("Fish", 2))

        set1.merge(set2)

        XCTAssertTrue(set1.count == 1)
        XCTAssertTrue(set1.isItemAvailable(ShoppingNote("Fish", 2)))
        XCTAssertFalse(set1.isItemAvailable(ShoppingNote("Fish", 1)))
    }

}
