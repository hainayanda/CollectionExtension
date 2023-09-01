//
//  ArrayFunctionalExtensionsSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 1/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class ArrayFunctionalExtensionsSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        let dummyEq1 = DummyEquatable()
        let dummyEq2 = DummyEquatable()
        let dummyEq3 = DummyEquatable()
        let dummyEq4 = DummyEquatable()
        
        let dummyObj1 = DummyObject()
        let dummyObj2 = DummyObject()
        let dummyObj3 = DummyObject()
        let dummyObj4 = DummyObject()
        
        describe("added") {
            context("one element") {
                it("should add element to array") {
                    expect([1, 2, 3].added(with: 4)).to(equal([1, 2, 3, 4]))
                }
                it("should add distinct element to array for hashable") {
                    expect([1, 2, 3].addedIfDistinct(with: 4)).to(equal([1, 2, 3, 4]))
                }
                it("should not add distinct element to array for hashable") {
                    expect([1, 2, 3].addedIfDistinct(with: 3)).to(equal([1, 2, 3]))
                }
                it("should add distinct element to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq3].addedIfDistinct(with: dummyEq4)).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should not add distinct element to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq3].addedIfDistinct(with: dummyEq3)).to(equal([dummyEq1, dummyEq2, dummyEq3]))
                }
                it("should add distinct element to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].addedIfDistinct(with: dummyObj4)).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should not add distinct element to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].addedIfDistinctInstance(with: dummyObj3)).to(equal([dummyObj1, dummyObj2, dummyObj3]))
                }
                it("should add distinct element to array with comparator") {
                    expect([1, 2, 3].addedIfDistinct(with: 4, where: ==))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not add distinct element to array with comparator") {
                    expect([1, 2, 3].addedIfDistinct(with: 3, where: ==))
                        .to(equal([1, 2, 3]))
                }
                it("should add distinct element to array with projection") {
                    expect([1, 2, 3].addedIfDistinct(with: 4, { $0 }))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not add distinct element to array with projection") {
                    expect([1, 2, 3].addedIfDistinct(with: 3, { $0 }))
                        .to(equal([1, 2, 3]))
                }
                it("should add distinct element to array with keypath") {
                    expect([1, 2, 3].addedIfDistinct(with: 4, using: \.description))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not add distinct element to array with keypath") {
                    expect([1, 2, 3].addedIfDistinct(with: 3, using: \.description))
                        .to(equal([1, 2, 3]))
                }
            }
            context("sequence") {
                it("should add elements to array") {
                    expect([1, 2, 3].added(withContentsOf: [4, 5])).to(equal([1, 2, 3, 4, 5]))
                }
                it("should add distinct elements to array for hashable") {
                    expect([1, 2, 3].addedAllDistinct(in: [2, 3, 4])).to(equal([1, 2, 3, 4]))
                }
                it("should add distinct elements to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq3].addedAllDistinct(in: [dummyEq2, dummyEq3, dummyEq4])).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should add distinct elements to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].addedAllDistinctInstances(in: [dummyObj2, dummyObj3, dummyObj4])).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should add distinct elements to array with comparator") {
                    expect([1, 2, 3].addedAllDistinct(in: [2, 3, 4], where: ==))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should add distinct elements to array with projection") {
                    expect([1, 2, 3].addedAllDistinct(in: [2, 3, 4], { $0 }))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should add distinct elements to array with keypath") {
                    expect([1, 2, 3].addedAllDistinct(in: [2, 3, 4], using: \.description))
                        .to(equal([1, 2, 3, 4]))
                }
            }
        }
        describe("inserted") {
            context("one element") {
                it("should insert element to array") {
                    expect([1, 2, 4].inserted(with: 3, at: 2)).to(equal([1, 2, 3, 4]))
                }
                it("should insert distinct element to array for hashable") {
                    expect([1, 2, 4].insertedIfDistinct(with: 3, at: 2)).to(equal([1, 2, 3, 4]))
                }
                it("should not insert distinct element to array for hashable") {
                    expect([1, 2, 3].insertedIfDistinct(with: 3, at: 2)).to(equal([1, 2, 3]))
                }
                it("should insert distinct element to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq4].insertedIfDistinct(with: dummyEq3, at: 2)).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should not insert distinct element to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq3].insertedIfDistinct(with: dummyEq3, at: 2)).to(equal([dummyEq1, dummyEq2, dummyEq3]))
                }
                it("should insert distinct element to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj4].insertedIfDistinct(with: dummyObj3, at: 2)).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should not insert distinct element to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].insertedIfDistinctInstance(with: dummyObj3, at: 2)).to(equal([dummyObj1, dummyObj2, dummyObj3]))
                }
                it("should insert distinct element to array with comparator") {
                    expect([1, 2, 4].insertedIfDistinct(with: 3, at: 2, where: ==))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not insert distinct element to array with comparator") {
                    expect([1, 2, 3].insertedIfDistinct(with: 3, at: 2, where: ==))
                        .to(equal([1, 2, 3]))
                }
                it("should insert distinct element to array with projection") {
                    expect([1, 2, 4].insertedIfDistinct(with: 3, at: 2, { $0 }))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not insert distinct element to array with projection") {
                    expect([1, 2, 3].insertedIfDistinct(with: 3, at: 2, { $0 }))
                        .to(equal([1, 2, 3]))
                }
                it("should insert distinct element to array with keypath") {
                    expect([1, 2, 4].insertedIfDistinct(with: 3, at: 2, using: \.description))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should not insert distinct element to array with keypath") {
                    expect([1, 2, 3].insertedIfDistinct(with: 3, at: 2, using: \.description))
                        .to(equal([1, 2, 3]))
                }
            }
            context("sequence") {
                it("should insert elements to array") {
                    expect([1, 2, 5].inserted(withContentsOf: [3, 4], at: 2)).to(equal([1, 2, 3, 4, 5]))
                }
                it("should insert distinct elements to array for hashable") {
                    expect([1, 2, 4].insertedAllDistinct(in: [2, 3, 4], at: 2)).to(equal([1, 2, 3, 4]))
                }
                it("should insert distinct elements to array for equatable") {
                    expect([dummyEq1, dummyEq2, dummyEq4].insertedAllDistinct(in: [dummyEq2, dummyEq3, dummyEq4], at: 2)).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should insert distinct elements to array for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj4].insertedAllDistinctInstances(in: [dummyObj2, dummyObj3, dummyObj4], at: 2)).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should insert distinct elements to array with comparator") {
                    expect([1, 2, 4].insertedAllDistinct(in: [2, 3, 4], at: 2, where: ==))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should insert distinct elements to array with projection") {
                    expect([1, 2, 4].insertedAllDistinct(in: [2, 3, 4], at: 2, { $0 }))
                        .to(equal([1, 2, 3, 4]))
                }
                it("should insert distinct elements to array with keypath") {
                    expect([1, 2, 4].insertedAllDistinct(in: [2, 3, 4], at: 2, using: \.description))
                        .to(equal([1, 2, 3, 4]))
                }
            }
        }
        describe("removed") {
            context("one element") {
                it("should remove using index") {
                    expect([1, 2, 3].removed(at: 1)).to(equal([1, 3]))
                }
                it("should remove last k") {
                    expect([1, 2, 3].removedLast(2)).to(equal([1]))
                }
                it("should remove first k") {
                    expect([1, 2, 3].removedFirst(2)).to(equal([3]))
                }
                it("should remove for equatable") {
                    expect([1, 2, 3].removedAll(2)).to(equal([1, 3]))
                }
                it("should not remove for equatable") {
                    expect([1, 2, 3].removedAll(4)).to(equal([1, 2, 3]))
                }
                it("should remove for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].removedAllInstances(dummyObj2)).to(equal([dummyObj1, dummyObj3]))
                }
                it("should not remove for instance") {
                    expect([dummyObj1, dummyObj2, dummyObj3].removedAllInstances(dummyObj4)).to(equal([dummyObj1, dummyObj2, dummyObj3]))
                }
                it("should remove using comparator") {
                    expect([1, 2, 3].removedAll { $0 == 2 }).to(equal([1, 3]))
                }
                it("should not remove using hashable") {
                    expect([1, 2, 3].removedAll { $0 == 4 }).to(equal([1, 2, 3]))
                }
            }
            context("sequence") {
            }
        }
    }
    // swiftlint:enable function_body_length
}
