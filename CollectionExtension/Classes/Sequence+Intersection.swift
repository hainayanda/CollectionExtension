//
//  Sequence+Intersection.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    
    /// Create new array contains intersection of this sequence with another sequence.
    /// It will use element projection to differentiate each element
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this sequence
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New array of element
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let intersection: Set<H> = try Set(otherSequence.map(projection))
        return try filter { try intersection.contains(projection($0)) }
    }
    
    /// Create new array contains intersection of this sequence with another sequence.
    /// It will compare elements using a given closure
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this sequence
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New array of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        return filter { element in
            otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    /// Create new array contains intersection of this sequence with another sequence.
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this sequence
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New array of element
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    
    /// Create new array contains intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this sequence
    /// - Returns: New array of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    
    /// Create new array contains intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this sequence
    /// - Returns: New array of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    
    /// Create new array contains instances intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this sequence
    /// - Returns: New array of instances
    @inlinable public func intersectInstances<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}

// MARK: LazySequence

extension LazySequenceProtocol {
    
    /// Create new lazy sequence contains intersection of this sequence with another sequence.
    /// It will use element projection to differentiate each element
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this lazy sequence
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New lazy sequence of element
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, using projection: @escaping (Element) -> H) -> LazyFilterSequence<Elements> where S.Element == Element {
        lazy var intersection: Set<H> = Set(otherSequence.map(projection))
        return filter { intersection.contains(projection($0)) }
    }
    
    /// Create new lazy sequence contains intersection of this sequence with another sequence.
    /// It will compare elements using a given closure
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this lazy sequence
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New lazy sequence of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S, where consideredSame: @escaping (Element, Element) -> Bool) -> LazyFilterSequence<Elements> where S.Element == Element {
        return filter { element in
            otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    /// Create new lazy sequence contains intersection of this sequence with another sequence.
    /// - Parameters:
    ///   - otherSequence: Other sequence that will intersect with this lazy sequence
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New lazy sequence of element
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension LazySequenceProtocol where Element: Hashable {
    
    /// Create new lazy sequence contains intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this lazy sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { $0 })
    }
}

extension LazySequenceProtocol where Element: Equatable {
    
    /// Create new lazy sequence contains intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this lazy sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    
    /// Create new lazy sequence contains instances intersection of this sequence with another sequence.
    /// - Parameter otherSequence: Other sequence that will intersect with this lazy sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func intersectInstances<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}
