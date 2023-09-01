//
//  Sequence+Intersection.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let intersection: Set<H> = try Set(otherSequence.map(projection))
        return try filter { try intersection.contains(projection($0)) }
    }
    
    @inlinable public func intersect<S: Sequence>(with otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        return filter { element in
            otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    @inlinable public func intersectInstances<S: Sequence>(with otherSequence: S) -> [Element] where S.Element == Element {
        intersect(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}

// MARK: LazySequence

extension LazySequenceProtocol {
    
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, using projection: @escaping (Element) -> H) -> LazyFilterSequence<Elements> where S.Element == Element {
        lazy var intersection: Set<H> = Set(otherSequence.map(projection))
        return filter { intersection.contains(projection($0)) }
    }
    
    @inlinable public func intersect<S: Sequence>(with otherSequence: S, where consideredSame: @escaping (Element, Element) -> Bool) -> LazyFilterSequence<Elements> where S.Element == Element {
        return filter { element in
            otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    @inlinable public func intersect<S: Sequence, H: Hashable>(with otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension LazySequenceProtocol where Element: Hashable {
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { $0 })
    }
}

extension LazySequenceProtocol where Element: Equatable {
    @inlinable public func intersect<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    @inlinable public func intersectInstances<S: Sequence>(with otherSequence: S) -> LazyFilterSequence<Elements> where S.Element == Element {
        intersect(with: otherSequence, using: { ObjectIdentifier($0) })
    }
}
