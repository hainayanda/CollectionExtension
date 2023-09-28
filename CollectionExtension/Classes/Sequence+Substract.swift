//
//  Sequence+Substract.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    
    /// Create new array from this sequence substracted by another sequence.
    /// It will use element projection to differentiate each element
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New array of element
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let substraction: Set<H> = try Set(otherSequence.map(projection))
        return try filter { try !substraction.contains(projection($0)) }
    }
    
    /// Create new array from this sequence substracted by another sequence
    /// It will compare elements using a given closure
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New array of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        return filter { element in
            !otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    /// Create new array from this sequence substracted by another sequence
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New array of element
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    
    /// Create new array from this sequence substracted by another sequence
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New array of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    
    /// Create new array from this sequence substracted by another sequence
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New array of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    
    /// Create new array from this sequence substracted by another sequence
    /// It will differentiate the element by instance
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New array of element
    @inlinable public func substractInstances<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { ObjectIdentifier($0) })
    }
}

// MARK: LazySequence

extension LazySequenceProtocol {
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// It will use element projection to differentiate each element
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New lazy sequence of element
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, using projection: @escaping (Element) -> H) -> LazyFilterSequence<Elements> where S.Element == Element {
        lazy var substraction: Set<H> = Set(otherSequence.map(projection))
        return filter { !substraction.contains(projection($0)) }
    }
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// It will compare elements using a given closure
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New lazy sequence of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S, where consideredSame: @escaping (Element, Element) -> Bool) -> LazyFilterSequence<Elements> where S.Element == Element {
        return filter { element in
            !otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// - Parameters:
    ///   - otherSequence: Other sequence to be substracted to this sequence
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New lazy sequence of element
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> LazyFilterSequence<Elements> where S.Element == Element {
        substract(by: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension LazySequence where Element: Hashable {
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        substract(by: otherSequence, using: { $0 })
    }
}

extension LazySequenceProtocol where Element: Equatable {
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        substract(by: otherSequence, where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    
    /// Create new lazy sequence from this lazy sequence substracted by another sequence
    /// It will differentiate the element by instance 
    /// - Parameter otherSequence: Other sequence to be substracted to this sequence
    /// - Returns: New lazy sequence of element
    @inlinable public func substractInstances<S: Sequence>(by otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        substract(by: otherSequence, using: { ObjectIdentifier($0) })
    }
}
