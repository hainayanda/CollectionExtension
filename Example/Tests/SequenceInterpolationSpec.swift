//
//  SequenceInterpolationSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceInterpolationSpec: QuickSpec {
    
    override class func spec() {
        it("should do insert one element interpolated on sequence") {
            let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            let expected1 = [1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9]
            let expected2 = [1, 2, 0, 3, 4, 0, 5, 6, 0, 7, 8, 0, 9]
            let expected3 = [1, 2, 3, 0, 4, 5, 6, 0, 7, 8, 9]
            expect(array.interpolate(forEach: 1, element: 0)).to(equal(expected1))
            expect(array.interpolate(forEach: 2, element: 0)).to(equal(expected2))
            expect(array.interpolate(forEach: 3, element: 0)).to(equal(expected3))
        }
        it("should do insert multiple element interpolated on sequence") {
            let array = [1, 2, 3, 4, 5, 6, 7, 8]
            let expected1 = [1, 0, 9, 2, 0, 9, 3, 0, 9, 4, 0, 9, 5, 0, 9, 6, 0, 9, 7, 0, 9, 8]
            let expected2 = [1, 2, 0, 9, 3, 4, 0, 9, 5, 6, 0, 9, 7, 8]
            let expected3 = [1, 2, 3, 0, 9, 4, 5, 6, 0, 9, 7, 8]
            expect(array.interpolate(forEach: 1, elements: [0, 9])).to(equal(expected1))
            expect(array.interpolate(forEach: 2, elements: [0, 9])).to(equal(expected2))
            expect(array.interpolate(forEach: 3, elements: [0, 9])).to(equal(expected3))
        }
    }
}
