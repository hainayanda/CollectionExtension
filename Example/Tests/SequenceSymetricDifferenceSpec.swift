//
//  SequenceSymetricDifferenceSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceSymetricDifferenceSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        let dummy1 = DummyObject()
        let dummy2 = DummyObject()
        let dummy3 = DummyObject()
        let dummy4 = DummyObject()
        let dummy5 = DummyObject()
        let dummy6 = DummyObject()
        let dummy7 = DummyObject()
        let dummy8 = DummyObject()
        context("regular sequence") {
            it("should symetric difference sequence using projection") {
                let array = [1, 2, 3, 4, 5].symetricDifference(with: [4, 5, 6, 7, 8]) { $0 }
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence using comparison") {
                let array = [1, 2, 3, 4, 5].symetricDifference(with: [4, 5, 6, 7, 8], where: ==)
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence using keypath") {
                let array = [1, 2, 3, 4, 5].symetricDifference(with: [4, 5, 6, 7, 8], by: \.description)
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for hashable") {
                let array = [1, 2, 3, 4, 5].symetricDifference(with: [4, 5, 6, 7, 8])
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for equatable") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].symetricDifference(with: [dummy4, dummy5, dummy6, dummy7, dummy8])
                let expected = [dummy1, dummy2, dummy3, dummy6, dummy7, dummy8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for object") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].symetricDifferenceInstances(with: [dummy4, dummy5, dummy6, dummy7, dummy8])
                let expected = [dummy1, dummy2, dummy3, dummy6, dummy7, dummy8]
                expect(array).to(equal(expected))
            }
        }
        context("lazy sequence") {
            it("should symetric difference sequence using projection") {
                let array = [1, 2, 3, 4, 5].lazy.symetricDifference(with: [4, 5, 6, 7, 8]) { $0 }.toArray()
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence using comparison") {
                let array = [1, 2, 3, 4, 5].lazy.symetricDifference(with: [4, 5, 6, 7, 8], where: ==).toArray()
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence using keypath") {
                let array = [1, 2, 3, 4, 5].lazy.symetricDifference(with: [4, 5, 6, 7, 8], by: \.description).toArray()
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for hashable") {
                let array = [1, 2, 3, 4, 5].lazy.symetricDifference(with: [4, 5, 6, 7, 8]).toArray()
                let expected = [1, 2, 3, 6, 7, 8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for equatable") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.symetricDifference(with: [dummy4, dummy5, dummy6, dummy7, dummy8]).toArray()
                let expected = [dummy1, dummy2, dummy3, dummy6, dummy7, dummy8]
                expect(array).to(equal(expected))
            }
            it("should symetric difference sequence for object") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.symetricDifferenceInstances(with: [dummy4, dummy5, dummy6, dummy7, dummy8]).toArray()
                let expected = [dummy1, dummy2, dummy3, dummy6, dummy7, dummy8]
                expect(array).to(equal(expected))
            }
        }
    }
    // swiftlint:enable function_body_length
}
