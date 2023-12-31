//
//  Dictionary+Extensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Dictionary {
    
    /// Map Dictionary keys to another keys
    /// Key generated must be unique, otherwise it will throw CollectionExtensionError.duplicatedKey
    /// - Complexity: O(*n*), where *n* is the length of this dictionary.
    /// - Parameter transform: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    /// - Throws: rethrows or CollectionExtensionError
    @inlinable public func mapKeys<K: Hashable>(_ transform: (Key) throws -> K) throws -> [K: Value] {
        var result: [K: Value] = [:]
        for (key, value) in self {
            let newKey = try transform(key)
            guard !result.contains(key: newKey) else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[newKey] = value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys
    /// It will overwrite the value of the same keys if it has any
    /// - Complexity: O(*n*), where *n* is the length of this dictionary
    /// - Parameter transform: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    @inlinable public func overwriteMapKeys<K: Hashable>(_ transform: (Key) throws -> K) rethrows -> [K: Value] {
        var result: [K: Value] = [:]
        for (key, value) in self {
            let newKey = try transform(key)
            result[newKey] = value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys
    /// If new key is nil, it will then ignore it and proceed with next key
    /// Key generated must be unique, otherwise it will throw CollectionExtensionError.duplicatedKey
    /// - Complexity: O(*n*), where *n* is the length of this dictionary
    /// - Parameter transform: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    /// - Throws: rethrows or CollectionExtensionError
    @inlinable public func compactMapKeys<K: Hashable>(_ transform: (Key) throws -> K?) throws -> [K: Value] {
        var result: [K: Value] = [:]
        for (key, value) in self {
            guard let newKey = try transform(key) else { continue }
            guard !result.contains(key: newKey) else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[newKey] = value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys
    /// If new key is nil, it will then ignore it and proceed with next key
    /// It will overwrite the value of the same keys if it has any
    /// - Complexity: O(*n*), where *n* is the length of this dictionary
    /// - Parameter transform: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    @inlinable public func overwriteCompactMapKeys<K: Hashable>(_ transform: (Key) throws -> K?) rethrows -> [K: Value] {
        var result: [K: Value] = [:]
        for (key, value) in self {
            guard let newKey = try transform(key) else { continue }
            result[newKey] = value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys and values to another values
    /// Key generated must be unique, otherwise it will throw CollectionExtensionError.duplicatedKey
    /// - Complexity: O(*n*), where *n* is the length of this dictionary
    /// - Parameter transform: Closure that map the old keys and values to the new one
    /// - Returns: New dictionary with new set of keys and values
    /// - Throws: rethrows or CollectionExtensionError
    @inlinable public func mapKeyValues<K: Hashable, V>(_ transform: (Key, Value) throws -> (key: K, value: V)) throws -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in self {
            let pair = try transform(key, value)
            guard !result.contains(key: pair.key) else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[pair.key] = pair.value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys and values to another values
    /// Key generated must be unique, otherwise it will throw CollectionExtensionError.duplicatedKey
    /// It will overwrite the value of the same keys if it has any
    /// - Parameter transform: Closure that map the old keys and values to the new one
    /// - Returns: New dictionary with new set of keys and values
    @inlinable public func overwriteMapKeyValues<K: Hashable, V>(_ transform: (Key, Value) throws -> (key: K, value: V)) rethrows -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in self {
            let pair = try transform(key, value)
            result[pair.key] = pair.value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys and values to another values
    /// If new key and value is nil, it will then ignore it and proceed with next key
    /// Key generated must be unique, otherwise it will throw CollectionExtensionError.duplicatedKey
    /// - Complexity: O(*n*), where *n* is the length of this dictionary
    /// - Parameter mapper: Closure that map the old keys and values to the new one
    /// - Returns: New dictionary with new set of keys and values
    /// - Throws: rethrows or CollectionExtensionError
    @inlinable public func compactMapKeyValues<K: Hashable, V>(_ transform: (Key, Value) throws -> (key: K, value: V)?) throws -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in self {
            guard let pair = try transform(key, value) else { continue }
            guard !result.contains(key: pair.key) else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[pair.key] = pair.value
        }
        return result
    }
    
    /// Map Dictionary keys to another keys and values to another values
    /// If new key and value is nil, it will then ignore it and proceed with next key
    /// It will overwrite the value of the same keys if it has any
    /// - Parameter transform: Closure that map the old keys and values to the new one
    /// - Returns: New dictionary with new set of keys and values
    @inlinable public func overwriteCompactMapKeyValues<K: Hashable, V>(_ transform: (Key, Value) throws -> (key: K, value: V)?) rethrows -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in self {
            guard let pair = try transform(key, value) else { continue }
            result[pair.key] = pair.value
        }
        return result
    }
    
    /// Return true if the collection contains a key
    /// - Parameter key: Key to search
    /// - Returns: True if key found, false if otherwise
    @inlinable public func contains(key: Key) -> Bool {
        self[key] != nil
    }
    
    /// Return true if the collection contains a value
    /// - Parameter matched: Closure that accept a value and return boolean to indicate that the value is matched
    /// - Returns: True if value found, false if otherwise
    @inlinable public func containsValue(_ matched: (Value) -> Bool) -> Bool {
        values.contains(where: matched)
    }
}

extension Dictionary where Value: Equatable {
    
    /// Return true if the collection contains a value
    /// - Parameter value: Value to search
    /// - Returns: True if value found, false if otherwise
    @inlinable public func contains(value: Value) -> Bool {
        containsValue { $0 == value }
    }
}

extension Dictionary where Value: AnyObject {
    
    /// Return true if the collection contains a instance
    /// - Parameter instance: Instance to search
    /// - Returns: True if instance found, false if otherwise
    @inlinable public func contains(instance: Value) -> Bool {
        containsValue { $0 === instance }
    }
}
