//
//  Sequence+Substract.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, using projection: (Element) throws -> H) rethrows -> [Element] where S.Element == Element {
        let substraction: Set<H> = try Set(otherSequence.map(projection))
        return try filter { try !substraction.contains(projection($0)) }
    }
    
    @inlinable public func substract<S: Sequence>(by otherSequence: S, where consideredSame: (Element, Element) -> Bool) -> [Element] where S.Element == Element {
        return filter { element in
            !otherSequence.contains(where: { consideredSame(element, $0) })
        }
    }
    
    @inlinable public func substract<S: Sequence, H: Hashable>(by otherSequence: S, by propertyKeyPath: KeyPath<Element, H>) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { $0[keyPath: propertyKeyPath] })
    }
}

extension Sequence where Element: Hashable {
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { $0 })
    }
}

extension Sequence where Element: Equatable {
    @inlinable public func substract<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, where: ==)
    }
}

extension Sequence where Element: AnyObject {
    @inlinable public func substractInstances<S: Sequence>(by otherSequence: S) -> [Element] where S.Element == Element {
        substract(by: otherSequence, using: { ObjectIdentifier($0) })
    }
}
