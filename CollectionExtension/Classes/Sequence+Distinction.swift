//
//  Sequence+Distinction.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    /// - Parameter projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: Array of distinct element
    @inlinable public func distinct<H: Hashable>(using projection: (Element) throws -> H) rethrows -> [Element] {
        var filtered: Set<H> = .init()
        return try filter { element in
            let hashable = try projection(element)
            guard !filtered.contains(hashable) else {
                return false
            }
            filtered.insert(hashable)
            return true
        }
    }
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    /// - Parameter propertyKeypath: Key path of the element that conform equatable that will be used as comparison
    /// - Returns: Array of distinct element
    @inlinable public func distinct<P: Hashable>(by propertyKeypath: KeyPath<Element, P>) -> [Element] {
        distinct { $0[keyPath: propertyKeypath] }
    }
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    /// - Parameter consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: Array of distinct element
    @inlinable public func distinct(where consideredSame: (Element, Element) -> Bool) -> [Element] {
        var filtered: [Element] = []
        return filter { element in
            guard !filtered.contains(where: { consideredSame($0, element) }) else {
                return false
            }
            filtered.append(element)
            return true
        }
    }
}

extension Sequence where Element: Hashable {
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    @inlinable public var unique: [Element] {
        distinct { $0 }
    }
}

extension Sequence where Element: Equatable {
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    @inlinable public var unique: [Element] {
        distinct(where: ==)
    }
}

extension Sequence where Element: AnyObject {
    
    /// Return an array of distinct elements in this sequence while still maintaining the original order
    @inlinable public var uniqueInstances: [Element] {
        distinct { ObjectIdentifier($0) }
    }
}

// MARK: LazySequenceProtocol

extension LazySequenceProtocol {
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    /// - Parameter projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: Lazy sequence of distinct element
    @inlinable public func distinct<H: Hashable>(using projection: @escaping (Element) -> H) -> LazyFilterSequence<Elements> {
        lazy var filtered: Set<H> = .init()
        return filter { element in
            let hashable = projection(element)
            guard !filtered.contains(hashable) else {
                return false
            }
            filtered.insert(hashable)
            return true
        }
    }
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    /// - Parameter propertyKeypath: Key path of the element that conform equatable that will be used as comparison
    /// - Returns: Lazy sequence of distinct element
    @inlinable public func distinct<P: Hashable>(by propertyKeypath: KeyPath<Element, P>) -> LazyFilterSequence<Elements> {
        distinct { $0[keyPath: propertyKeypath] }
    }
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    /// - Parameter consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: Lazy sequence of distinct element
    @inlinable public func distinct(where consideredSame: @escaping (Element, Element) -> Bool) -> LazyFilterSequence<Elements> {
        var filtered: [Element] = []
        return filter { element in
            guard !filtered.contains(where: { consideredSame($0, element) }) else {
                return false
            }
            filtered.append(element)
            return true
        }
    }
}

extension LazySequenceProtocol where Element: Hashable {
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    @inlinable public var unique: LazyFilterSequence<Elements> {
        distinct { $0 }
    }
}

extension LazySequenceProtocol where Element: Equatable {
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    @inlinable public var unique: LazyFilterSequence<Elements> {
        distinct(where: ==)
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    
    /// Return a lazy sequence of distinct elements from this lazy sequence
    @inlinable public var uniqueInstances: LazyFilterSequence<Elements> {
        distinct { ObjectIdentifier($0) }
    }
}
