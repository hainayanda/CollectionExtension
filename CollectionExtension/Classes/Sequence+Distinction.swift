//
//  Sequence+Distinction.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
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
    
    @inlinable public func distinct<P: Hashable>(by propertyKeypath: KeyPath<Element, P>) -> [Element] {
        distinct { $0[keyPath: propertyKeypath] }
    }
    
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
    @inlinable public var unique: [Element] {
        distinct { $0 }
    }
}

extension Sequence where Element: Equatable {
    @inlinable public var unique: [Element] {
        distinct(where: ==)
    }
}

extension Sequence where Element: AnyObject {
    @inlinable public var uniqueInstances: [Element] {
        distinct { ObjectIdentifier($0) }
    }
}
