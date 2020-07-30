//
//  ShoppingNoteSet.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

class ShoppingNoteSet<T : Hashable>: Equatable {
    private var additions: [T: TimeInterval]
    private var removals: [T: TimeInterval]

    var items: [ShoppingNote<T>] {
        var results = [ShoppingNote<T>]()

        additions.forEach { (value, timestamp) in
            if let removed = removals[value], removed >= timestamp {
                // item is removed
            } else {
                results.append(ShoppingNote(value, timestamp))
            }
        }

        return results.sorted(by: { (a, b) -> Bool in
            return a < b
        })
    }

    var count: Int {
        return items.count
    }

    init() {
        additions = [:]
        removals = [:]
    }

    public subscript(index: Int) -> ShoppingNote<T> {
        return self.items[index]
    }

    // Public methods
    func add(_ newItem: ShoppingNote<T>) {
        if let old = additions[newItem.item] {
            if old < newItem.timestamp {
                additions[newItem.item] = newItem.timestamp
            }
        } else {
            additions[newItem.item] = newItem.timestamp
        }
    }

    func remove(_ item: ShoppingNote<T>) {
        if let old = removals[item.item] {
            if old < item.timestamp {
                removals[item.item] = item.timestamp
            }
        } else {
            removals[item.item] = item.timestamp
        }
    }

    func merge(_ anotherSet: ShoppingNoteSet) {
        anotherSet.additions.forEach { (value, timestamp) in
            self.add(ShoppingNote(value, timestamp))
        }

        anotherSet.removals.forEach { (value, timestamp) in
            self.remove(ShoppingNote(value, timestamp))
        }
    }

    func isItemAvailable(_ itemToBeChecked: ShoppingNote<T>) -> Bool {
        for item in items where ShoppingNote.equal(lhs: item, rhs: itemToBeChecked) {
            return true
        }

        return false
    }

    // Equatable
    static func == (lhs: ShoppingNoteSet, rhs: ShoppingNoteSet) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }

        for i in 0..<lhs.count {
            if ShoppingNote.notEqual(lhs: lhs[i], rhs: rhs[i]) {
                return false
            }
        }

        return true
    }
}
