//
//  Sequence+SymetricDifference.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New array of element
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let left = try self.substract(by: otherSequence, using: projection)
        let right = try otherSequence.substract(by: self, using: projection)
        return left + right
    }
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New array of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        let left = self.substract(by: otherSequence, where: consideredSame)
        let right = otherSequence.substract(by: self, where: consideredSame)
        return left + right
    }
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New array of element
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New array of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New array of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    
    /// Create new array containing symetric difference of this sequence and another sequence
    /// It will differentiate the element by instance
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New array of element
    @inlinable public func symetricDifferenceInstances<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}

// MARK: LazySequence

extension LazySequenceProtocol {
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - projection: A closure that accept an element and return hashable value
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, using projection: @escaping (Element) -> H) -> LazyConcatenateSequence<Element> where S.Element == Element {
        let left = self.substract(by: otherSequence, using: projection)
        let right = otherSequence.substract(by: self, using: projection)
        return left.concantenate(with: right)
    }
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - consideredSame: A closure that will accept two element and return true if the element is equal and false if otherwise
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S, where consideredSame: @escaping (Element, Element) -> Bool) -> LazyConcatenateSequence<Element> where S.Element == Element {
        let left = self.substract(by: otherSequence, where: consideredSame)
        let right = otherSequence.substract(by: self, where: consideredSame)
        return left.concantenate(with: right)
    }
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// - Parameters:
    ///   - otherSequence: Another sequence to be compare with this sequence for symetric difference
    ///   - propertyKeyPath: Keypath to the element property that will be used as equal comparison
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension LazySequenceProtocol where Element: Hashable {
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0 })
    }
}

extension LazySequenceProtocol where Element: Equatable {
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    
    /// Create new lazy sequence containing symetric difference of this sequence and another sequence
    /// It will differentiate the element by instance 
    /// - Parameter otherSequence: Another sequence to be compare with this sequence for symetric difference
    /// - Returns: New lazy sequence of element
    @inlinable public func symetricDifferenceInstances<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}
