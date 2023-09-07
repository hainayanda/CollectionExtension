//
//  Sequence+Drop.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: Sequence

extension Sequence {
    
    /// Create new array with dropped elements
    /// - Parameter elementFound: Closure that accept an element and return boolean that return true to stop the dropping
    /// - Returns: New array with dropped elements
    @inlinable public func dropAllUntil(_ elementFound: (Element) -> Bool) -> [Element] {
        var found = false
        return filter { element in
            if found { return true }
            found = elementFound(element)
            return found
        }
    }
    
    /// Create new array with dropped elements
    /// - Parameter elementFound: Closure that accept an element and return boolean that return true to start the dropping
    /// - Returns: New array with dropped elements
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
    
    /// Create new array with dropped elements
    /// - Parameter element: Element that if match will stop the dropping
    /// - Returns: New array with dropped elements
    @inlinable public func dropAllUntil(find element: Element) -> [Element] {
        dropAllUntil { $0 == element }
    }
    
    /// Create new array with dropped elements
    /// - Parameter element: Element that if match will start the dropping
    /// - Returns: New array with dropped elements
    @inlinable public func dropAllAfter(find element: Element) -> [Element] {
        dropAllAfter { $0 == element }
    }
}

extension Sequence where Element: AnyObject {
    
    /// Create new array with dropped instances
    /// - Parameter element: Instances that if match will stop the dropping
    /// - Returns: New array with dropped elements
    @inlinable public func dropAllUntil(findInstance element: Element) -> [Element] {
        dropAllUntil { $0 === element }
    }
    
    /// Create new array with dropped instances
    /// - Parameter element: Instances that if match will start the dropping
    /// - Returns: New array with dropped elements
    @inlinable public func dropAllAfter(findInstance element: Element) -> [Element] {
        dropAllAfter { $0 === element }
    }
}

// MARK: Sequence

extension LazySequenceProtocol {
    
    /// Create lazy sequence with dropped elements
    /// - Parameter elementFound: Closure that accept an element and return boolean that return true to stop the dropping
    /// - Returns: Lazy sequence with dropped elements
    @inlinable public func dropAllUntil(_ elementFound: @escaping (Element) -> Bool) -> LazyFilterSequence<Elements> {
        var found = false
        return filter { element in
            if found { return true }
            found = elementFound(element)
            return found
        }
    }
    
    /// Create lazy sequence with dropped elements
    /// - Parameter elementFound: Closure that accept an element and return boolean that return true to start the dropping
    /// - Returns: Lazy sequence with dropped elements
    @inlinable public func dropAllAfter(_ elementFound: @escaping (Element) -> Bool) -> LazyFilterSequence<Elements> {
        var found = false
        return filter { element in
            if found { return false }
            found = elementFound(element)
            return true
        }
    }
}

extension LazySequenceProtocol where Element: Equatable {
    
    /// Create lazy sequence with dropped elements
    /// - Parameter element: Element that if match will stop the dropping
    /// - Returns: Lazy sequence with dropped elements
    @inlinable public func dropAllUntil(find element: Element) -> LazyFilterSequence<Elements> {
        dropAllUntil { $0 == element }
    }
    
    /// Create lazy sequence with dropped elements
    /// - Parameter element: Element that if match will start the dropping
    /// - Returns: Lazy sequence with dropped elements
    @inlinable public func dropAllAfter(find element: Element) -> LazyFilterSequence<Elements> {
        dropAllAfter { $0 == element }
    }
}

extension LazySequenceProtocol where Element: AnyObject {
    
    /// Create lazy sequence with dropped instances
    /// - Parameter element: Instance that if match will stop the dropping
    /// - Returns: Lazy sequence with dropped instances
    @inlinable public func dropAllUntil(findInstance element: Element) -> LazyFilterSequence<Elements> {
        dropAllUntil { $0 === element }
    }
    
    /// Create lazy sequence with dropped instances
    /// - Parameter element: Instance that if match will start the dropping
    /// - Returns: Lazy sequence with dropped instances
    @inlinable public func dropAllAfter(findInstance element: Element) -> LazyFilterSequence<Elements> {
        dropAllAfter { $0 === element }
    }
}
