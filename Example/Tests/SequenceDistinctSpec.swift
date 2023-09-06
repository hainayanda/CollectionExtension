//
//  SequenceDistinctSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceDistinctSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        context("regular sequencce") {
            it("should distinct using projection") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].distinct { $0 }).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using keypath") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].distinct(by: \.description)).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using keypath") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].distinct(where: ==)).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using hashable") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].unique).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using equatable") {
                let dummy1 = DummyEquatable()
                let dummy2 = DummyEquatable()
                let dummy3 = DummyEquatable()
                let dummy4 = DummyEquatable()
                let dummy5 = DummyEquatable()
                let array = [dummy1, dummy2, dummy2, dummy3, dummy3, dummy3, dummy4, dummy4, dummy5]
                expect(array.unique).to(equal([dummy1, dummy2, dummy3, dummy4, dummy5]))
            }
            it("should distinct using instance") {
                let dummy1 = DummyObject()
                let dummy2 = DummyObject()
                let dummy3 = DummyObject()
                let dummy4 = DummyObject()
                let dummy5 = DummyObject()
                let array = [dummy1, dummy2, dummy2, dummy3, dummy3, dummy3, dummy4, dummy4, dummy5]
                expect(array.uniqueInstances).to(equal([dummy1, dummy2, dummy3, dummy4, dummy5]))
            }
        }
        context("lazy sequencce") {
            it("should distinct using projection") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].lazy.distinct { $0 }.toArray()).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using keypath") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].lazy.distinct(by: \.description).toArray()).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using keypath") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].lazy.distinct(where: ==).toArray()).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using hashable") {
                expect([1, 2, 2, 3, 3, 3, 4, 4, 5].lazy.unique.toArray()).to(equal([1, 2, 3, 4, 5]))
            }
            it("should distinct using equatable") {
                let dummy1 = DummyEquatable()
                let dummy2 = DummyEquatable()
                let dummy3 = DummyEquatable()
                let dummy4 = DummyEquatable()
                let dummy5 = DummyEquatable()
                let array = [dummy1, dummy2, dummy2, dummy3, dummy3, dummy3, dummy4, dummy4, dummy5]
                expect(array.lazy.unique.toArray()).to(equal([dummy1, dummy2, dummy3, dummy4, dummy5]))
            }
            it("should distinct using instance") {
                let dummy1 = DummyObject()
                let dummy2 = DummyObject()
                let dummy3 = DummyObject()
                let dummy4 = DummyObject()
                let dummy5 = DummyObject()
                let array = [dummy1, dummy2, dummy2, dummy3, dummy3, dummy3, dummy4, dummy4, dummy5]
                expect(array.lazy.uniqueInstances.toArray()).to(equal([dummy1, dummy2, dummy3, dummy4, dummy5]))
            }
        }
    }
    // swiftlint:enable function_body_length
}
