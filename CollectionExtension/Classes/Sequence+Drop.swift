//
//  Sequence+Drop.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
    @inlinable public func dropAllUntil(_ elementFound: (Element) -> Bool) -> [Element] {
        var found = false
        return filter { element in
            if found { return true }
            found = elementFound(element)
            return found
        }
    }
    
    @inlinable public func dropAllAfter(_ elementFound: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for element in self {
            result.append(element)
            if elementFound(element) { return result }
        }
        return result
    }
}

extension Sequence where Element: Equatable {
    @inlinable public func dropAllUntil(find element: Element) -> [Element] {
        dropAllUntil { $0 == element }
    }
    
    @inlinable public func dropAllAfter(find element: Element) -> [Element] {
        dropAllAfter { $0 == element }
    }
}

extension Sequence where Element: AnyObject {
    @inlinable public func dropAllUntil(findInstance element: Element) -> [Element] {
        dropAllUntil { $0 === element }
    }
    
    @inlinable public func dropAllAfter(findInstance element: Element) -> [Element] {
        dropAllAfter { $0 === element }
    }
}
