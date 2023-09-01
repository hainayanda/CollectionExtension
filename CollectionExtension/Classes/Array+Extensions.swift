//
//  Array+Extensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Array {
    
    @inlinable public mutating func appendIfDistinct(_ element: Element, where consideredSame: (Element, Element) throws -> Bool) rethrows {
        guard !(try self.contains(where: { try consideredSame(element, $0) })) else {
            return
        }
        append(element)
    }
    
    @inlinable public mutating func appendIfDistinct<E: Equatable>(_ element: Element, _ projection: (Element) throws -> E) rethrows {
        try appendIfDistinct(element, where: { lhs, rhs in
            try projection(lhs) == projection(rhs)
        })
    }
    
    @inlinable public mutating func appendIfDistinct<E: Equatable>(_ element: Element, using propertyKeyPath: KeyPath<Element, E>) {
        appendIfDistinct(element) { $0[keyPath: propertyKeyPath] }
    }
    
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S, where consideredSame: (Element, Element) -> Bool) where S.Element == Element {
        let toAppend = sequence.substract(by: self, where: consideredSame)
        append(contentsOf: toAppend)
    }
    
    @inlinable public mutating func appendAllDistinct<S: Sequence, H: Hashable>(in sequence: S, _ projection: (Element) throws -> H) rethrows where S.Element == Element {
        let toAppend = try sequence.substract(by: self, using: projection)
        append(contentsOf: toAppend)
    }
    
    @inlinable public mutating func appendAllDistinct<S: Sequence, H: Hashable>(in sequence: S, using propertyKeyPath: KeyPath<Element, H>) where S.Element == Element {
        appendAllDistinct(in: sequence) { $0[keyPath: propertyKeyPath] }
    }
    
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int, where consideredSame: (Element, Element) throws -> Bool) rethrows {
        guard !(try self.contains(where: { try consideredSame(element, $0) })) else {
            return
        }
        insert(element, at: index)
    }
    
    @inlinable public mutating func insertIfDistinct<E: Equatable>(_ element: Element, at index: Int, _ projection: (Element) throws -> E) rethrows {
        try insertIfDistinct(element, at: index, where: { lhs, rhs in
            try projection(lhs) == projection(rhs)
        })
    }
    
    @inlinable public mutating func insertIfDistinct<E: Equatable>(_ element: Element, at index: Int, using propertyKeyPath: KeyPath<Element, E>) {
        insertIfDistinct(element, at: index) { $0[keyPath: propertyKeyPath] }
    }
    
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int, where consideredSame: (Element, Element) -> Bool) where S.Element == Element {
        let toInsert = sequence.substract(by: self, where: consideredSame)
        insert(contentsOf: toInsert, at: index)
    }
    
    @inlinable public mutating func insertAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, _ projection: (Element) throws -> H) rethrows where S.Element == Element {
        let toInsert = try sequence.substract(by: self, using: projection)
        insert(contentsOf: toInsert, at: index)
    }
    
    @inlinable public mutating func insertAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, using propertyKeyPath: KeyPath<Element, H>) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { $0[keyPath: propertyKeyPath] }
    }
    
    @inlinable public mutating func removeAll<E: Equatable>(_ element: Element, using projection: (Element) -> E) {
        let toRemove = projection(element)
        removeAll { projection($0) == toRemove }
    }
    
    @inlinable public mutating func removeAll<S: Sequence, H: Hashable>(in sequence: S, _ projection: (Element) -> H) where S.Element == Element{
        let toRemove = Set(sequence.map(projection))
        removeAll { toRemove.contains(projection($0)) }
    }
}

extension Array where Element: Hashable {
    
    @inlinable public mutating func appendIfDistinct(_ element: Element) {
        appendIfDistinct(element) { $0 }
    }
    
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence) { $0 }
    }
    
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index) { $0 }
    }
    
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { $0 }
    }
}

extension Array where Element: Equatable {
    @inlinable public mutating func appendIfDistinct(_ element: Element) {
        appendIfDistinct(element, where: ==)
    }
    
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence, where: ==)
    }
    
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index, where: ==)
    }
    
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index, where: ==)
    }
}

extension Array where Element: AnyObject {
    @inlinable public mutating func appendIfDistinctInstance(_ element: Element) {
        appendIfDistinct(element, where: ===)
    }
    
    @inlinable public mutating func appendAllDistinctInstances<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence) { ObjectIdentifier($0) }
    }
    
    @inlinable public mutating func insertIfDistinctInstance(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index) { ObjectIdentifier($0) }
    }
    
    @inlinable public mutating func insertAllDistinctInstances<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { ObjectIdentifier($0) }
    }
}
