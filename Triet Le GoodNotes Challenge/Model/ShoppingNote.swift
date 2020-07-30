//
//  ShoppingNote.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

struct ShoppingNote<T : Hashable>: Comparable {
    let item: T
    let timestamp: TimeInterval

    init(_ t: T, _ timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.item = t
        self.timestamp = timestamp
    }

    static func ==(lhs: ShoppingNote, rhs: ShoppingNote) -> Bool {
        return lhs.item == rhs.item
    }

    static func !=(lhs: ShoppingNote, rhs: ShoppingNote) -> Bool {
        return !(lhs == rhs)
    }

    static func equal(lhs: ShoppingNote, rhs: ShoppingNote) -> Bool {
        return lhs.item == rhs.item &&
            lhs.timestamp == rhs.timestamp
    }

    static func notEqual(lhs: ShoppingNote, rhs: ShoppingNote) -> Bool {
        return !equal(lhs: lhs, rhs: rhs)
    }

    // Comparable
    static func <(lhs: ShoppingNote, rhs: ShoppingNote) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}
