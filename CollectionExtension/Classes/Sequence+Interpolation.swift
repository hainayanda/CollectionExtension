//
//  Sequence+Interpolation.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

extension Sequence {
    @inlinable public func interpolate(forEach iteration: Int, element insertingElement: Element) -> [Element] {
        var result: [Element] = []
        for (index, element) in self.enumerated() {
            result.append(element)
            if index % iteration == 0 {
                result.append(insertingElement)
            }
        }
        return result
    }
    
    @inlinable public func interpolate<S: Sequence>(forEach iteration: Int, elements insertingElements: S) -> [Element] where S.Element == Element {
        var result: [Element] = []
        for (index, element) in self.enumerated() {
            result.append(element)
            if index % iteration == 0 {
                result.append(contentsOf: insertingElements)
            }
        }
        return result
    }
}
