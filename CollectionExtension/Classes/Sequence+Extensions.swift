//
//  Sequence+Extensions.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 1/9/23.
//

import Foundation

public extension Sequence {
    /// Convert the sequence to array
    /// - Returns: Array of element
    func toArray() -> [Element] {
        self as? [Element] ?? Array(self)
    }
}
