//
//  SequenceTypeEraseSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceTypeEraseSpec: QuickSpec {
    
    override class func spec() {
        it("should iterate same as original") {
            var counter = 0
            [0, 1, 2, 3, 4, 5].eraseToAnySequence().forEach { element in
                expect(element).to(equal(counter))
                counter += 1
            }
        }
        it("should iterate same as original") {
            var counter = 0
            [0, 1, 2, 3, 4, 5].lazy.eraseToAnyLazySequence().forEach { element in
                expect(element).to(equal(counter))
                counter += 1
            }
        }
    }
}
