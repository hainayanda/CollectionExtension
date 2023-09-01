//
//  Sequence+SymetricDifference.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let left = try self.substract(by: otherSequence, using: projection)
        let right = try otherSequence.substract(by: self, using: projection)
        return left + right
    }
    
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        let left = self.substract(by: otherSequence, where: consideredSame)
        let right = otherSequence.substract(by: self, where: consideredSame)
        return left + right
    }
    
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    @inlinable public func symetricDifferenceInstances<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        symetricDifference(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}

// MARK: LazySequence

extension LazySequenceProtocol {
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, using projection: @escaping (Element) -> H) -> LazyConcatenateSequence<Element> where S.Element == Element {
        let left = self.substract(by: otherSequence, using: projection)
        let right = otherSequence.substract(by: self, using: projection)
        return left.concantenate(with: right)
    }
    
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S, where consideredSame: @escaping (Element, Element) -> Bool) -> LazyConcatenateSequence<Element> where S.Element == Element {
        let left = self.substract(by: otherSequence, where: consideredSame)
        let right = otherSequence.substract(by: self, where: consideredSame)
        return left.concantenate(with: right)
    }
    
    @inlinable public func symetricDifference<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension LazySequenceProtocol where Element: Hashable {
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { $0 })
    }
}

extension LazySequenceProtocol where Element: Equatable {
    @inlinable public func symetricDifference<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    @inlinable public func symetricDifferenceInstances<S: Sequence>(with otherSequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        symetricDifference(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}
