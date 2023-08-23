//
//  Sequence+Group.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
    
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
    
    @inlinable public func group<K: Hashable>(by propertyKeypath: KeyPath<Element, K>) -> [K: [Element]] {
        group { $0[keyPath: propertyKeypath] }
    }
    
    @inlinable public func transformToDictionary<K: Hashable>(keyed transform: (Int, Element) throws -> K) throws -> [K: Element] {
        var result: [K: Element] = [:]
        for (index, element) in self.enumerated() {
            let key = try transform(index, element)
            guard result[key] == nil else {
                throw CollectionExtensionError.duplicatedKey
            }
            result[key] = element
        }
        return result
    }
    
    @inlinable public func transformToDictionary<K: Hashable>(keyedBy propertyKeypath: KeyPath<Element, K>) throws -> [K: Element] {
        try transformToDictionary { _, element in
            element[keyPath: propertyKeypath]
        }
    }
}

