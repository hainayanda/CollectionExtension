//
//  Sequence+Group.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
    
    /// Create a dictionary that group element with same key to one array as dictionary value
    /// - Parameter keyProvider: Closure that accept an element and return a key for those element
    /// - Returns: Dictionary of key and array of elements
    @inlinable public func group<K: Hashable>(by keyProvider: (Element) throws -> K) rethrows -> [K: [Element]] {
        var result: [K: [Element]] = [:]
        for element in self {
            let key = try keyProvider(element)
            var group = result[key] ?? []
            group.append(element)
            result[key] = group
        }
        return result
    }
    
    /// Create a dictionary that group element with same key to one array as dictionary value
    /// - Parameter propertyKeypath: Key path for the element to be used as a key
    /// - Returns: Dictionary of key and array of elements
    @inlinable public func group<K: Hashable>(by propertyKeypath: KeyPath<Element, K>) -> [K: [Element]] {
        group { $0[keyPath: propertyKeypath] }
    }
    
    /// Create a dictionary that map the element with a key. It will throw error if the key is duplicated.
    /// - Parameter transform: Closure that accept and index and element and return key for those element
    /// - Returns: Dictionary of key and element
    @inlinable public func transformToDictionary<K: Hashable>(keyed transform: (Element) throws -> K) throws -> [K: Element] {
        var result: [K: Element] = [:]
        for element in self {
            let key = try transform(element)
            guard result[key] == nil else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[key] = element
        }
        return result
    }
    
    /// Create a dictionary that map the element with a key. It will throw error if the key is duplicated.
    /// - Parameter propertyKeypath: Key path for the element to be used as a key
    /// - Returns: Dictionary of key and element
    @inlinable public func transformToDictionary<K: Hashable>(keyedBy propertyKeypath: KeyPath<Element, K>) throws -> [K: Element] {
        try transformToDictionary { element in
            element[keyPath: propertyKeypath]
        }
    }
}

