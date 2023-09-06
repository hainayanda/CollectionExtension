//
//  LazyContantenateSequenceSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 1/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class LazyContantenateSequenceSpec: QuickSpec {
    override class func spec() {
        it("should concantenate sequence") {
            let sequence1 = [1, 2, 3].lazy
            let sequence2 = DoublyLinkedList([4, 5, 6]).lazy
            expect(sequence1.concantenate(with: sequence2).toArray()).to(equal([1, 2, 3, 4, 5, 6]))
        }
        it("should concantenate sequences") {
            let sequence1 = [1, 2, 3].lazy
            let sequence2 = [4, 5, 6].lazy
            let sequence3 = [7, 8, 9].lazy
            expect(sequence1.concantenate(with: sequence2, sequence3).toArray()).to(equal([1, 2, 3, 4, 5, 6, 7, 8, 9]))
        }
    }
}
