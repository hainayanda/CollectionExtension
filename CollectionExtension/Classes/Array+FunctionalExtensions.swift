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
    
    /// Create new array added with given element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: Element added
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: New array with added element
    @inlinable public func addedIfDistinct(with element: Element, where consideredSame: (Element, Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.appendIfDistinct(element, where: consideredSame) }
    }
    
    /// Create new array added with given element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: Element added
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: New array with added element
    @inlinable public func addedIfDistinct<E: Equatable>(with element: Element, _ projection: (Element) throws -> E) rethrows -> [Element] {
        try mutatingNewArray { try $0.appendIfDistinct(element, projection) }
    }
    
    /// Create new array added with given element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: Element added
    ///   - propertyKeyPath: Key path of the element that conform equatable that will be used as comparison
    /// - Returns: New array with added element
    @inlinable public func addedIfDistinct<E: Equatable>(with element: Element, using propertyKeyPath: KeyPath<Element, E>) -> [Element] {
        mutatingNewArray { $0.appendIfDistinct(element, using: propertyKeyPath) }
    }
    
    /// Create new array added with given contents of the sequence where the element is not present in the array at the end of the array
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinct(in: sequence, where: consideredSame) }
    }
    
    /// Create new array added with given contents of the sequence where the element is not present in the array at the end of the array
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, _ projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        try mutatingNewArray { try $0.appendAllDistinct(in: sequence, projection) }
    }
    
    /// Create new array added with given contents of the sequence where the element is not present in the array at the end of the array
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, using propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinct(in: sequence, using: propertyKeyPath) }
    }
    
    /// Create new array added with given element at the given index
    /// - Complexity: O(*n*), where *n* is the length of arrays
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - element: Element added
    /// - Returns: New array with inserted element
    @inlinable public func inserted(with element: Element, at index: Int) -> [Element] {
        mutatingNewArray { $0.insert(element, at: index) }
    }
    
    /// Create new array added with given contents of the collection at the given index
    /// - Complexity: O(*n* + *m*), where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - collection: Collection of the elements
    /// - Returns: New array with inserted element
    @inlinable public func inserted<C: Collection>(withContentsOf collection: C, at index: Int) -> [Element] where C.Element == Element {
        mutatingNewArray { $0.insert(contentsOf: collection, at: index) }
    }
    
    /// Create new array added with given element at the given index if the element is not present in the array
    /// - Parameters:
    ///   - element: Element inserted
    ///   - index: The position at which to insert the new element.
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: New array with inserted element
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int, where consideredSame: (Element, Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.insertIfDistinct(element, at: index, where: consideredSame) }
    }
    
    /// Create new array added with given element at the given index if the element is not present in the array
    /// - Parameters:
    ///   - element: Element inserted
    ///   - index: The position at which to insert the new element.
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: New array with inserted element
    @inlinable public func insertedIfDistinct<E: Equatable>(with element: Element, at index: Int, _ projection: (Element) throws -> E) rethrows -> [Element] {
        try mutatingNewArray { try $0.insertIfDistinct(element, at: index, projection) }
    }
    
    /// Create new array added with given element at the given index if the element is not present in the array
    /// - Parameters:
    ///   - element: Element inserted
    ///   - index: The position at which to insert the new element.
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    /// - Returns: New array with inserted element
    @inlinable public func insertedIfDistinct<E: Equatable>(with element: Element, at index: Int, using propertyKeyPath: KeyPath<Element, E>) -> [Element] {
        mutatingNewArray { $0.insertIfDistinct(element, at: index, using: propertyKeyPath) }
    }
    
    /// Create new array added with given elements where the element is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - index: The position at which to insert the new element.
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: New array with inserted sequence
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.insertAllDistinct(in: sequence, at: index, where: consideredSame) }
    }
    
    /// Create new array added with given elements where the element is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - index: The position at which to insert the new element.
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: New array with inserted sequence
    @inlinable public func insertedAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, _ projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        try mutatingNewArray { try $0.insertAllDistinct(in: sequence, at: index, projection) }
    }
    
    /// Create new array added with given elements where the element is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - index: The position at which to insert the new element.
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    /// - Returns: New array with inserted sequence
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
    /// - Returns: New array with removed elements
    @inlinable public func removedAll(where found: (Element) -> Bool) -> [Element] {
        mutatingNewArray { $0.removeAll(where: found) }
    }
    
    /// Create new array with removed last k element
    /// - Parameter k: Number of element to be removed
    /// - Returns: New array with removed elements
    @inlinable public func removedLast(_ k: Int = 1) -> [Element] {
        mutatingNewArray { $0.removeLast(k) }
    }
    
    /// Create new array with removed first k element
    /// - Parameter k: Number of element to be removed
    /// - Returns: New array with removed elements
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
    
    /// Create new array added with given element at the end of the array if the element is not present in the array
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable public func addedIfDistinct(with element: Element) -> [Element] {
        addedIfDistinct(with: element) { $0 }
    }
    
    /// Create new array added with given contents of the sequence where the element is not present in the array at the end of the array
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        addedAllDistinct(in: sequence) { $0 }
    }
    
    /// Create new array added with given element at the given index if the element is not present in the array
    /// - Parameters:
    ///   - element: Element inserted
    ///   - index: The position at which to insert the new element.
    /// - Returns: New array with inserted element
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int) -> [Element] {
        insertedIfDistinct(with: element, at: index) { $0 }
    }
    
    /// Create new array added with given elements where the element is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - index: The position at which to insert the new element.
    /// - Returns: New array with inserted sequence
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        insertedAllDistinct(in: sequence, at: index) { $0 }
    }
}

extension Array where Element: Equatable {
    
    /// Create new array added with given element at the end of the array if the element is not present in the array
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable public func addedIfDistinct(with element: Element) -> [Element] {
        addedIfDistinct(with: element, where: ==)
    }
    
    /// Create new array added with given contents of the sequence where the element is not present in the array at the end of the array
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinct<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        addedAllDistinct(in: sequence, where: ==)
    }
    
    /// Create new array added with given element at the given index if the element is not present in the array
    /// - Parameters:
    ///   - element: Element inserted
    ///   - index: The position at which to insert the new element.
    /// - Returns: New array with inserted element
    @inlinable public func insertedIfDistinct(with element: Element, at index: Int) -> [Element] {
        insertedIfDistinct(with: element, at: index, where: ==)
    }
    
    /// Create new array added with given elements where the element is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the elements
    ///   - index: The position at which to insert the new element.
    /// - Returns: New array with inserted sequence
    @inlinable public func insertedAllDistinct<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        insertedAllDistinct(in: sequence, at: index, where: ==)
    }
    
    /// Create new array with given element removed
    /// - Parameter element: Element to be removed
    /// - Returns: New array with removed elements
    @inlinable public func removedAll(_ element: Element) -> [Element] {
        mutatingNewArray { $0.removeAll(element) }
    }
}

extension Array where Element: AnyObject {
    
    /// Create new array added with given instance at the end of the array if the instance is not present in the array
    /// - Parameter element: Instance added
    /// - Returns: New array with added instance
    @inlinable public func addedIfDistinctInstance(with element: Element) -> [Element] {
        mutatingNewArray { $0.appendIfDistinctInstance(element) }
    }
    
    /// Create new array added with given contents of the sequence where the instance is not present in the array at the end of the array
    /// - Parameter sequence: Sequence of the instance
    /// - Returns: New array with added sequence
    @inlinable public func addedAllDistinctInstances<S: Sequence>(in sequence: S) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.appendAllDistinctInstances(in: sequence) }
    }
    
    /// Create new array added with given element at the given index if the instance is not present in the array
    /// - Parameters:
    ///   - element: Instance inserted
    ///   - index: The position at which to insert the new instance.
    /// - Returns: New array with inserted instance
    @inlinable public func insertedIfDistinctInstance(with element: Element, at index: Int) -> [Element] {
        mutatingNewArray { $0.insertIfDistinctInstance(element, at: index) }
    }
    
    /// Create new array added with given instances where the instance is not present in the array at the given index
    /// - Parameters:
    ///   - sequence: Sequence of the instances
    ///   - index: The position at which to insert the new instance.
    /// - Returns: New array with inserted sequence
    @inlinable public func insertedAllDistinctInstances<S: Sequence>(in sequence: S, at index: Int) -> [Element] where S.Element == Element {
        mutatingNewArray { $0.insertAllDistinctInstances(in: sequence, at: index) }
    }
    
    /// Create new array with given instance removed
    /// - Parameter element: Instance to be removed
    /// - Returns: New array with removed instances
    @inlinable public func removedAllInstances(_ element: Element) -> [Element] {
        mutatingNewArray { $0.removeAllInstances(element) }
    }
}
