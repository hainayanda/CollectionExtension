//
//  Array+Extensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Array {
    
    @inlinable public subscript(safe index: Int) -> Element? {
        get {
            guard index >= 0 && index < count else {
                return nil
            }
            return self[index]
        } set {
            guard index >= 0 && index < count else {
                return
            }
            guard let newValue else {
                remove(at: index)
                return
            }
            self[index] = newValue
        }
    }
    
    /// Adds a new element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: The element to append to the array.
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public mutating func appendIfDistinct(_ element: Element, where consideredSame: (Element, Element) throws -> Bool) rethrows {
        guard !(try self.contains(where: { try consideredSame(element, $0) })) else {
            return
        }
        append(element)
    }
    
    /// Adds a new element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: The element to append to the array.
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public mutating func appendIfDistinct<E: Equatable>(_ element: Element, _ projection: (Element) throws -> E) rethrows {
        try appendIfDistinct(element, where: { lhs, rhs in
            try projection(lhs) == projection(rhs)
        })
    }
    
    /// Adds a new element at the end of the array if the element is not present in the array
    /// - Parameters:
    ///   - element: The element to append to the array.
    ///   - propertyKeyPath: Key path of the element that conform equatable that will be used as comparison
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public mutating func appendIfDistinct<E: Equatable>(_ element: Element, using propertyKeyPath: KeyPath<Element, E>) {
        appendIfDistinct(element) { $0[keyPath: propertyKeyPath] }
    }
    
    /// Adds the elements of a sequence that not present on thes array to the end of the array.
    /// - Parameters:
    ///   - sequence: The elements to append to the array.
    ///   - consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Complexity: O(*n*^2), where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S, where consideredSame: (Element, Element) -> Bool) where S.Element == Element {
        let toAppend = sequence.substract(by: self, where: consideredSame)
        append(contentsOf: toAppend)
    }
    
    /// Adds the elements of a sequence that not present on thes array to the end of the array.
    /// - Parameters:
    ///   - sequence: The elements to append to the array.
    ///   - projection: Closure that accept one element and convert it to a value that conform hashable that will be used as comparison
    /// - Complexity: O(*n*) on average, where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinct<S: Sequence, H: Hashable>(in sequence: S, _ projection: (Element) throws -> H) rethrows where S.Element == Element {
        let toAppend = try sequence.substract(by: self, using: projection)
        append(contentsOf: toAppend)
    }
    
    /// Adds the elements of a sequence that not present on thes array to the end of the array.
    /// - Parameters:
    ///   - sequence: The elements to append to the array.
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    /// - Complexity: O(*n*) on average, where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinct<S: Sequence, H: Hashable>(in sequence: S, using propertyKeyPath: KeyPath<Element, H>) where S.Element == Element {
        appendAllDistinct(in: sequence) { $0[keyPath: propertyKeyPath] }
    }
    
    /// Inserts a new element at the specified position if the element is not present in the array.
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    ///   - consideredSame: closure that accept two element and return boolean that determined that the element is considered same or not
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int, where consideredSame: (Element, Element) throws -> Bool) rethrows {
        guard !(try self.contains(where: { try consideredSame(element, $0) })) else {
            return
        }
        insert(element, at: index)
    }
    
    /// Inserts a new element at the specified position if the element is not present in the array.
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    ///   - projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    @inlinable public mutating func insertIfDistinct<E: Equatable>(_ element: Element, at index: Int, _ projection: (Element) throws -> E) rethrows {
        try insertIfDistinct(element, at: index, where: { lhs, rhs in
            try projection(lhs) == projection(rhs)
        })
    }
    
    /// Inserts a new element at the specified position if the element is not present in the array.
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    @inlinable public mutating func insertIfDistinct<E: Equatable>(_ element: Element, at index: Int, using propertyKeyPath: KeyPath<Element, E>) {
        insertIfDistinct(element, at: index) { $0[keyPath: propertyKeyPath] }
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new elements to insert into the array.
    ///   - index: The position at which to insert the new element.
    ///   - consideredSame: closure that accept two element and return boolean that determined that the element is considered same or not
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int, where consideredSame: (Element, Element) -> Bool) where S.Element == Element {
        let toInsert = sequence.substract(by: self, where: consideredSame)
        insert(contentsOf: toInsert, at: index)
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new elements to insert into the array.
    ///   - index: The position at which to insert the new elements.
    ///   - projection: Closure that accept one element and convert it to a value that conform hashable that will be used as comparison
    @inlinable public mutating func insertAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, _ projection: (Element) throws -> H) rethrows where S.Element == Element {
        let toInsert = try sequence.substract(by: self, using: projection)
        insert(contentsOf: toInsert, at: index)
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new elements to insert into the array.
    ///   - index: The position at which to insert the new elements.
    ///   - propertyKeyPath: Key path of the element that conform hashable that will be used as comparison
    @inlinable public mutating func insertAllDistinct<S: Sequence, H: Hashable>(in sequence: S, at index: Int, using propertyKeyPath: KeyPath<Element, H>) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { $0[keyPath: propertyKeyPath] }
    }
}

extension Array where Element: Hashable {
    
    /// Adds a new element at the end of the array if the element is not present in the array
    /// - Parameter element: The element to append to the array.
    /// - Complexity: O(*n*), where *n* is the length of the  sequence
    @inlinable public mutating func appendIfDistinct(_ element: Element) {
        appendIfDistinct(element) { $0 }
    }
    
    /// Adds the elements of a sequence that not present on thes array to the end of the array.
    /// - Parameter sequence: The elements to append to the array.
    /// - Complexity: O(*n*) on average, where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence) { $0 }
    }
    
    /// Inserts a new element at the specified position if the element is not present in the array.
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index) { $0 }
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new elements to insert into the array.
    ///   - index: The position at which to insert the new elements.
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { $0 }
    }
}

extension Array where Element: Equatable {
    
    /// Adds a new element at the end of the array if the element is not present in the array
    /// - Parameter element: The element to append to the array.
    /// - Complexity: O(*n*), where *n* is the length of the appending sequence
    @inlinable public mutating func appendIfDistinct(_ element: Element) {
        appendIfDistinct(element, where: ==)
    }
    
    /// Adds the elements of a sequence that not present on thes array to the end of the array.
    /// - Parameter sequence: The elements to append to the array.
    /// - Complexity: O(*n*^2), where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinct<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence, where: ==)
    }
    
    /// Inserts a new element at the specified position if the element is not present in the array.
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    @inlinable public mutating func insertIfDistinct(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index, where: ==)
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new elements to insert into the array.
    ///   - index: The position at which to insert the new elements.
    @inlinable public mutating func insertAllDistinct<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index, where: ==)
    }
    
    /// Removes all the elements that match the given element
    /// - Parameter element: The element to be removed
    @inlinable public mutating func removeAll(_ element: Element) {
        removeAll(where: { $0 == element })
    }
}

extension Array where Element: AnyObject {
    
    /// Adds a new instance at the end of the array if the element is not present in the array
    /// - Parameter element: The instance to append to the array.
    /// - Complexity: O(*n*), where *n* is the length of the appending sequence
    @inlinable public mutating func appendIfDistinctInstance(_ element: Element) {
        appendIfDistinct(element, where: ===)
    }
    
    /// Adds the instances of a sequence that not present on thes array to the end of the array.
    /// - Parameter sequence: The instance to append to the array.
    /// - Complexity: O(*n*) on average, where *n* is the length of the appending sequence
    @inlinable public mutating func appendAllDistinctInstances<S: Sequence>(in sequence: S) where S.Element == Element {
        appendAllDistinct(in: sequence) { ObjectIdentifier($0) }
    }
    
    /// Inserts a new instance at the specified position if the instance is not present in the array.
    /// - Parameters:
    ///   - element: The new instance to insert into the array.
    ///   - index: The position at which to insert the new instance.
    @inlinable public mutating func insertIfDistinctInstance(_ element: Element, at index: Int) {
        insertIfDistinct(element, at: index) { ObjectIdentifier($0) }
    }
    
    /// Inserts the elements of a sequence  that not present on thes array into the array at the specified position.
    /// - Parameters:
    ///   - sequence: The new instance to insert into the array.
    ///   - index: The position at which to insert the new instance.
    @inlinable public mutating func insertAllDistinctInstances<S: Sequence>(in sequence: S, at index: Int) where S.Element == Element {
        insertAllDistinct(in: sequence, at: index) { ObjectIdentifier($0) }
    }
    
    /// Removes all the instances that match the given instance
    /// - Parameter element: The instance to be removed
    @inlinable public mutating func removeAllInstances(_ element: Element) {
        removeAll(where: { $0 === element })
    }
}
