//
//  SequenceSubstractSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceSubstractSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        let dummy1 = DummyObject()
        let dummy2 = DummyObject()
        let dummy3 = DummyObject()
        let dummy4 = DummyObject()
        let dummy5 = DummyObject()
        context("regular sequence") {
            it("should substract sequence using projection") {
                let array = [1, 2, 3, 4, 5].substract(by: [4, 5]) { $0 }
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence using comparison") {
                let array = [1, 2, 3, 4, 5].substract(by: [4, 5], where: ==)
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence using keypath") {
                let array = [1, 2, 3, 4, 5].substract(by: [4, 5], by: \.description)
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for hashable") {
                let array = [1, 2, 3, 4, 5].substract(by: [4, 5])
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for equatable") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].substract(by: [dummy4, dummy5])
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for object") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].substractInstances(by: [dummy4, dummy5])
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
        }
        context("lazy sequence") {
            it("should substract sequence using projection") {
                let array = [1, 2, 3, 4, 5].lazy.substract(by: [4, 5]) { $0 }.toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence using comparison") {
                let array = [1, 2, 3, 4, 5].lazy.substract(by: [4, 5], where: ==).toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence using keypath") {
                let array = [1, 2, 3, 4, 5].lazy.substract(by: [4, 5], by: \.description).toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for hashable") {
                let array = [1, 2, 3, 4, 5].lazy.substract(by: [4, 5]).toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for equatable") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.substract(by: [dummy4, dummy5]).toArray()
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
            it("should substract sequence for object") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.substractInstances(by: [dummy4, dummy5]).toArray()
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
        }
    }
    // swiftlint:enable function_body_length
}
