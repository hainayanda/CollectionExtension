//
//  Median.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 02/08/22.
//

import Foundation

// MARK: Model

public enum Median<Element: Comparable>: Equatable {
    case single(Element)
    case double(Element, Element)
    case noMedian
}

public extension Median where Element: BinaryInteger {
    @inlinable var value: Double? {
        switch self {
        case .single(let element):
            return Double(element)
        case .double(let element1, let element2):
            return Double(element1 + element2) / 2
        case .noMedian:
            return nil
        }
    }
}

public extension Median where Element == Double {
    @inlinable var value: Double? {
        switch self {
        case .single(let element):
            return element
        case .double(let element1, let element2):
            return (element1 + element2) / 2
        case .noMedian:
            return nil
        }
    }
}

public extension Median where Element == Float {
    @inlinable var value: Float? {
        switch self {
        case .single(let element):
            return element
        case .double(let element1, let element2):
            return (element1 + element2) / 2
        case .noMedian:
            return nil
        }
    }
}

#if canImport(UIKit)
import UIKit

public extension Median where Element == CGFloat {
    @inlinable var value: CGFloat? {
        switch self {
        case .single(let element):
            return element
        case .double(let element1, let element2):
            return (element1 + element2) / 2
        case .noMedian:
            return nil
        }
    }
}
#endif
