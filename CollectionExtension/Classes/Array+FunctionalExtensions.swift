//
//  Array+FunctionalExtensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Array {
    /// Create new array added with given element at the end of the array
    /// - Complexity: O(1)
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable public func added(with element: Element) -> [Element] {
        mutatingNewArray { $0.append(element) }
    }
    
    /// Create new array added with given contents of the sequence at the end of the array
    /// - Complexity: O(*m*) on average, where *m* is the length of sequence
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable public func added<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.append(contentsOf: sequence) }
    }
    
    @inlinable public func addedIfDistinct(with element: Element, where consideredSame: (Element, Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.appendIfDistinct(element, where: consideredSame) }
    }
    
    @inlinable public func addedIfDistinct<E: Equatable>(with element: Element, _ projection: (Element) throws -> E) rethrows -> [Element] {
        try mutatingNewArray { try $0.appendIfDistinct(element, projection) }
    }
    
    @inlinable public func addedIfDistinct<E: Equatable>(with element: Element, using propertyKeyPath: KeyPath<Element, E>) -> [Element] {
        mutatingNewArray { $0.appendIfDistinct(element, using: propertyKeyPath) }
    }
    
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinct(in: sequence, where: consideredSame) }
    }
    
    @inlinable public func addedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, _ projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        try mutatingNewArray { try $0.appendAllDistinct(in: sequence, projection) }
    }
    
    @inlinable public func addedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, using propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinct(in: sequence, using: propertyKeyPath) }
    }
    
    /// Create new array added with given elements at the given index
    /// - Complexity: O(*n*), where *n* is the length of arrays
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - element: Element added
    /// - Returns: New array with added element
    @inlinable public func inserted(with element: Element, at index: Int) -> [Element] {
        mutatingNewArray { $0.insert(element, at: index) }
    }
    
    /// Create new array added with given contents of the collection at the given index
    /// - Complexity: O(*n* + *m*), where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - collection: Collection of the elements
    /// - Returns: New array with added collection
    @inlinable public func inserted<C: Collection>(withContentsOf collection: C, at index: Int) -> [Element] where C.Element == Element {
        mutatingNewArray { $0.insert(contentsOf: collection, at: index) }
    }
    
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int, where consideredSame: (Element, Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.insertIfDistinct(element, at: index, where: consideredSame) }
    }
    
    @inlinable public func insertedIfDistinct<E: Equatable>(with element: Element, at index: Int, _ projection: (Element) throws -> E) rethrows -> [Element] {
        try mutatingNewArray { try $0.insertIfDistinct(element, at: index, projection) }
    }
    
    @inlinable public func insertedIfDistinct<E: Equatable>(with element: Element, at index: Int, using propertyKeyPath: KeyPath<Element, E>) -> [Element] {
        mutatingNewArray { $0.insertIfDistinct(element, at: index, using: propertyKeyPath) }
    }
    
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.insertAllDistinct(in: sequence, at: index, where: consideredSame) }
    }
    
    @inlinable public func insertedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, _ projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        try mutatingNewArray { try $0.insertAllDistinct(in: sequence, at: index, projection) }
    }
    
    @inlinable public func insertedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, using propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.insertAllDistinct(in: sequence, at: index, using: propertyKeyPath) }
    }
    
    /// Create new array with removed element at given index
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter index: Index to remove
    /// - Returns: New array with removed element
    @inlinable public func removed(at index: Index) -> [Element] {
        mutatingNewArray { $0.remove(at: index) }
    }
    
    /// Create new array with removed element when element found
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter found: Closure to check element needs to be removed
    /// - Returns: New array with removed element
    @inlinable public func removedAll(where found: (Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.removeAll(where: found) }
    }
    
    @inlinable public func removedLast(_ k: Int = 1) -> [Element] {
        mutatingNewArray { $0.removeLast(k) }
    }
    
    @inlinable public func removedFirst(_ k: Int = 1) -> [Element] {
        mutatingNewArray { $0.removeFirst(k) }
    }
    
    @inlinable func mutatingNewArray(_ mutator: (inout [Element]) throws -> Void) rethrows -> [Element] {
        var newArray = self
        try mutator(&newArray)
        return newArray
    }
}

extension Array where Element: Hashable {
    
    @inlinable public func addedIfDistinct(with element: Element) -> [Element] {
        addedIfDistinct(with: element) { $0 }
    }
    
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        addedAllDistinct(in: sequence) { $0 }
    }
    
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int) -> [Element] {
        insertedIfDistinct(with: element, at: index) { $0 }
    }
    
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        insertedAllDistinct(in: sequence, at: index) { $0 }
    }
}

extension Array where Element: Equatable {
    
    @inlinable public func addedIfDistinct(with element: Element) -> [Element] {
        addedIfDistinct(with: element, where: ==)
    }
    
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        addedAllDistinct(in: sequence, where: ==)
    }
    
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int) -> [Element] {
        insertedIfDistinct(with: element, at: index, where: ==)
    }
    
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        insertedAllDistinct(in: sequence, at: index, where: ==)
    }
    
    @inlinable public func removedAll(_ element: Element) -> [Element] {
        removedAll { $0 == element }
    }
}

extension Array where Element: AnyObject {
    
    @inlinable public func addedIfDistinctInstance(with element: Element) -> [Element] {
        mutatingNewArray { $0.appendIfDistinctInstance(element) }
    }
    
    @inlinable public func addedAllDistinctInstances<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinctInstances(in: sequence) }
    }
    
    @inlinable public func insertedIfDistinctInstance(with element: Element, at index: Int) -> [Element] {
        mutatingNewArray { $0.insertIfDistinctInstance(element, at: index) }
    }
    
    @inlinable public func insertedAllDistinctInstances<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.insertAllDistinctInstances(in: sequence, at: index) }
    }
    
    @inlinable public func removedAllInstances(_ element: Element) -> [Element] {
        mutatingNewArray { $0.removeAll { $0 === element } }
    }
}
