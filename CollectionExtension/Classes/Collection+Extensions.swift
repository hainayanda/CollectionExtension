//
//  Collection+Extensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Collection {
    
    @inlinable public subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
    
    /// True if the collection is not empty
    @inlinable public var isNotEmpty: Bool {
        !isEmpty
    }
}

// MARK: Median

extension Collection where Element: Comparable {
    
    /// Find median of the array if its sorted
    /// - Complexity: O(*n*/2) on average, where *n* is the size of the collection
    @inlinable public var median: Median<Element> {
        guard count > 1 else {
            guard let median = self.first else {
                return .noMedian
            }
            return .single(median)
        }
        let medianIndex = count / 2
        let median = Array(
            self.dropFirst(medianIndex - 1)
                .prefix(2)
        )
        guard let last = median.last else { return .noMedian }
        guard let first = median.first, count % 2 == 0, last != first else {
            return .single(last)
        }
        return .double(first, last)
    }
}

// MARK: Sum

extension Collection where Element: AdditiveArithmetic {
    
    /// Sum all the elements in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var sum: Element {
        reduce(.zero) { partialResult, element in
            partialResult + element
        }
    }
}

// MARK: Average

extension Collection where Element: FloatingPoint {
    
    /// Calculate average value of the array elements
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var average: Element {
        var count = 0
        let sum: Element = reduce(.zero) { partialResult, element in
            count += 1
            return partialResult + element
        }
        return sum / Element(count)
    }
}

extension Collection where Element: BinaryInteger {
    
    /// Calculate average value of the array elements
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var average: Element {
        var count = 0
        let sum: Element = reduce(.zero) { partialResult, element in
            count += 1
            return partialResult + element
        }
        return sum / Element(count)
    }
}

// MARK: Smallest and Biggest

extension Collection where Element: Comparable {
    
    /// Find the smallest element in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var smallest: Element? {
        reduce(nil) { lastSmallest, element in
            guard let lastSmallest = lastSmallest else {
                return element
            }
            return lastSmallest > element ? element : lastSmallest
        }
    }
    
    /// Find the biggest element in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var biggest: Element? {
        reduce(nil) { lastBiggest, element in
            guard let lastBiggest = lastBiggest else {
                return element
            }
            return lastBiggest < element ? element : lastBiggest
        }
    }
}

// MARK: Modus

extension Collection where Element: Hashable {
    
    /// Return the element that appears most often in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var modus: Element? {
        var counted: [Element: Int] = [:]
        let lastModus: (element: Element?, count: Int) = (nil, 0)
        return reduce(lastModus) { lastModus, element in
            let currentCount = (counted[element] ?? 0) + 1
            counted[element] = currentCount
            return lastModus.count < currentCount ? (element, currentCount): lastModus
        }.element
    }
}

extension Collection {
    
    /// Return the element that appears most often in this array
    /// - Complexity: O(*n*^2)  at worst and O(*n*) at best, on average it should be O((*n*^2)/2), where *n* is the size of the sequence
    /// - Parameter consideredSame: Closure used to compare the elements
    /// - Returns: Element that appears most often in this array
    @inlinable public func modus(where consideredSame: (Element, Element) -> Bool) -> Element? {
        var remaining = Array(self)
        var lastModus: (element: Element?, count: Int) = (nil, 0)
        while let first = remaining.first {
            let lastRemainingCount = remaining.count
            remaining.removeAll { element in
                consideredSame(first, element)
            }
            let currentCount = lastRemainingCount - remaining.count
            lastModus = lastModus.count < currentCount ? (first, currentCount) : lastModus
        }
        return lastModus.element
    }
    
    /// Return the element that appears most often in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    /// - Parameter projection: Closure that accept an element and return hashable projection of it
    /// - Returns: Element that appears most often in this array
    @inlinable public func modus<H: Hashable>(using projection: (Element) -> H) -> Element? {
        var counted: [H: Int] = [:]
        let lastModus: (element: Element?, count: Int) = (nil, 0)
        return reduce(lastModus) { lastModus, element in
            let identifier = projection(element)
            let currentCount = (counted[identifier] ?? 0) + 1
            counted[identifier] = currentCount
            return lastModus.count < currentCount ? (element, currentCount): lastModus
        }.element
    }
    
    /// Return the element that appears most often in this array
    /// - Parameter propertyKeypath: Key path to the element property that conform Hashable that will be used as comparison
    /// - Returns: Element that appears most often in this array
    @inlinable public func modus<P: Hashable>(by propertyKeypath: KeyPath<Element, P>) -> Element? {
        modus { $0[keyPath: propertyKeypath] }
    }
}

extension Collection where Element: Equatable {
    /// Return the element that appears most often in this array
    /// - Complexity: O(*n*^2)  at worst and O(*n*+1) at best, on average it should be O((*n*^2)/2), where *n* is the size of the sequence
    @inlinable public var modus: Element? {
        modus(where: ==)
    }
}

extension Collection where Element: AnyObject {
    /// Return the object that appears most often in this array
    /// - Complexity: O(*n*)  on average, where *n* is the size of the sequence
    @inlinable public var modusInstances: Element? {
        modus { ObjectIdentifier($0) }
    }
}

public struct ElementCountPair<Element> {
    public let element: Element
    public let count: Int
    
    public init(_ element: Element, count: Int) {
        self.element = element
        self.count = count
    }
}

extension ElementCountPair: Equatable where Element: Equatable { }
extension ElementCountPair: Hashable where Element: Hashable { }

extension Collection {
    
    /// Return array of ElementCountPair with element and its count in the collection
    /// - Parameter consideredSame: Closure that accept two element and return boolean that determined that the element is considered same or not
    /// - Returns: Array of ElementCountPair
    @inlinable public func groupedByFrequency(where consideredSame: (Element, Element) -> Bool) -> [ElementCountPair<Element>] {
        distinct(where: consideredSame)
            .map { element in
                let count = elementCount { consideredSame($0, element) }
                return ElementCountPair(element, count: count)
            }
    }
    
    /// Return array of ElementCountPair with element and its count in the collection
    /// - Parameter projection: Closure that accept one element and convert it to a value that conform equatable that will be used as comparison
    /// - Returns: Array of ElementCountPair
    @inlinable public func groupedByFrequency<H: Hashable>(using projection: (Element) throws -> H) rethrows -> [ElementCountPair<Element>] {
        let grouped = try map(projection).groupedByFrequency()
        return try distinct(using: projection)
            .map { element in
                return try ElementCountPair(element, count: grouped[projection(element)] ?? 0)
            }
    }
    
    /// Return element count in the collection
    /// - Parameter matched: Closure that accept an element and return boolean indicated that the element matched or not
    /// - Returns: Count of the element found in the collection
    @inlinable public func elementCount(where matched: (Element) -> Bool) -> Int {
        reduce(0) { partialResult, element in
            return matched(element) ? partialResult + 1: partialResult
        }
    }
}

extension Collection where Element: Equatable {
    
    /// Return array of ElementCountPair with element and its count in the collection
    /// - Returns: Array of ElementCountPair
    @inlinable public func groupedByFrequency() -> [ElementCountPair<Element>] {
        groupedByFrequency(where: ==)
    }
    
    /// Return element count in the collection
    /// - Parameter element: element to be count
    /// - Returns: Count of the element found in the collection
    @inlinable public func elementCount(_ element: Element) -> Int {
        elementCount { $0 == element }
    }
}

extension Collection where Element: AnyObject {
    
    /// Return array of ElementCountPair with element and its count in the collection
    /// - Returns: Array of ElementCountPair
    @inlinable public func groupedInstancesByFrequency() -> [ElementCountPair<Element>] {
        groupedByFrequency { ObjectIdentifier($0) }
    }
    
    /// Return instance count in the collection
    /// - Parameter element: instance to be count
    /// - Returns: Count of the instance found in the collection
    @inlinable public func instanceCount(_ element: Element) -> Int {
        elementCount { $0 === element }
    }
}

extension Collection where Element: Hashable {
    
    /// Return Dictionary of Element and Int which represent the element count in this array
    /// - Complexity: O(*n*), where *n* is the size of the sequence
    /// - Returns: Dictionary of Element and Int
    @inlinable public func groupedByFrequency() -> [Element: Int] {
        reduce(into: [:]) { partialResult, element in
            partialResult[element] = (partialResult[element] ?? 0) + 1
        }
    }
}
