//
//  ArrayExtensionSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class ArrayExtensionsSpec: QuickSpec {
    
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
        let dummyObj5 = DummyObject()
        let dummyObj6 = DummyObject()
        context("common") {
            it("it should get element when index is in bounds") {
                expect([1, 2, 3][safe: 1]).to(equal(2))
            }
            it("it should get nil when index is out  of bounds") {
                expect([1, 2, 3][safe: 3]).to(beNil())
            }
            it("it should return true if its not empty") {
                expect([1, 2, 3].isNotEmpty).to(beTrue())
            }
            it("it should return false if its empty") {
                expect([Int]().isNotEmpty).to(beFalse())
            }
        }
        describe("append if distinct") {
            context("one element") {
                it("should append if distinct for hashable") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(4)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not append if not distinct for hashable") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(3, where: ==)
                    expect(array).to(equal([1, 2, 3]))
                }
                it("should append if distinct for equatable") {
                    var array = [dummyEq1, dummyEq2, dummyEq3]
                    array.appendIfDistinct(dummyEq4)
                    expect(array).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should not append if not distinct for equatable") {
                    var array = [dummyEq1, dummyEq2, dummyEq3]
                    array.appendIfDistinct(dummyEq3)
                    expect(array).to(equal([dummyEq1, dummyEq2, dummyEq3]))
                }
                it("should append if distinct for instance") {
                    var array = [dummyObj1, dummyObj2, dummyObj3]
                    array.appendIfDistinctInstance(dummyObj4)
                    expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should not append if not distinct for instance") {
                    var array = [dummyObj1, dummyObj2, dummyObj3]
                    array.appendIfDistinctInstance(dummyObj3)
                    expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3]))
                }
                it("should append if distinct using comparator") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(4)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not append if not distinct using comparator") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(3, where: ==)
                    expect(array).to(equal([1, 2, 3]))
                }
                it("should append if distinct using projection") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(4) { $0 }
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not append if not distinct using projection") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(3) { $0 }
                    expect(array).to(equal([1, 2, 3]))
                }
                it("should append if distinct using keypath") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(4, using: \.description)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not append if not distinct using keypath") {
                    var array = [1, 2, 3]
                    array.appendIfDistinct(3, using: \.description)
                    expect(array).to(equal([1, 2, 3]))
                }
            }
            context("sequence") {
                it("should append only distinct for hashable") {
                    var array = [1, 2, 3]
                    array.appendAllDistinct(in: [2, 3, 4])
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should append only distinct for equatable") {
                    var array = [dummyEq1, dummyEq2, dummyEq3]
                    array.appendAllDistinct(in: [dummyEq2, dummyEq3, dummyEq4])
                    expect(array).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should append only distinct for instance") {
                    var array = [dummyObj1, dummyObj2, dummyObj3]
                    array.appendAllDistinctInstances(in: [dummyObj2, dummyObj3, dummyObj4])
                    expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should append only distinct using comparator") {
                    var array = [1, 2, 3]
                    array.appendAllDistinct(in: [2, 3, 4], where: ==)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should append only distinct using projection") {
                    var array = [1, 2, 3]
                    array.appendAllDistinct(in: [2, 3, 4]) { $0 }
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should append only distinct using keypath") {
                    var array = [1, 2, 3]
                    array.appendAllDistinct(in: [2, 3, 4], using: \.description)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
            }
        }
        describe("insert if distinct") {
            context("one element") {
                it("should insert if distinct for hashable") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(3, at: 2)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should insert if distinct for equatable") {
                    var array = [dummyEq1, dummyEq2, dummyEq4]
                    array.insertIfDistinct(dummyEq3, at: 2)
                    expect(array).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should insert if distinct for instance") {
                    var array = [dummyObj1, dummyObj2, dummyObj4]
                    array.insertIfDistinctInstance(dummyObj3, at: 2)
                    expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should insert if distinct using comparator") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(3, at: 2, where: ==)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not insert if not distinct using comparator") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(4, at: 2, where: ==)
                    expect(array).to(equal([1, 2, 4]))
                }
                it("should insert if distinct using projection") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(3, at: 2) { $0 }
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not insert if not distinct using projection") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(4, at: 2) { $0 }
                    expect(array).to(equal([1, 2, 4]))
                }
                it("should insert if distinct using keypath") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(3, at: 2, using: \.description)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should not insert if not distinct using keypath") {
                    var array = [1, 2, 4]
                    array.insertIfDistinct(4, at: 2, using: \.description)
                    expect(array).to(equal([1, 2, 4]))
                }
            }
            context("sequence") {
                it("should insert only distinct for hashable") {
                    var array = [1, 2, 4]
                    array.insertAllDistinct(in: [2, 3, 4], at: 2)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should insert only distinct for equatable") {
                    var array = [dummyEq1, dummyEq2, dummyEq4]
                    array.insertAllDistinct(in: [dummyEq2, dummyEq3, dummyEq4], at: 2)
                    expect(array).to(equal([dummyEq1, dummyEq2, dummyEq3, dummyEq4]))
                }
                it("should insert only distinct for instance") {
                    var array = [dummyObj1, dummyObj2, dummyObj4]
                    array.insertAllDistinctInstances(in: [dummyObj2, dummyObj3, dummyObj4], at: 2)
                    expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4]))
                }
                it("should insert only distinct using comparator") {
                    var array = [1, 2, 4]
                    array.insertAllDistinct(in: [2, 3, 4], at: 2, where: ==)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should insert only distinct using projection") {
                    var array = [1, 2, 4]
                    array.insertAllDistinct(in: [2, 3, 4], at: 2) { $0 }
                    expect(array).to(equal([1, 2, 3, 4]))
                }
                it("should insert only distinct using keypath") {
                    var array = [1, 2, 4]
                    array.insertAllDistinct(in: [2, 3, 4], at: 2, using: \.description)
                    expect(array).to(equal([1, 2, 3, 4]))
                }
            }
        }
        describe("removeAll") {
            it("should remove all element") {
                var array = [1, 6, 6, 2, 3, 6, 4, 5, 6]
                array.removeAll(6)
                expect(array).to(equal([1, 2, 3, 4, 5]))
            }
            it("should remove all instance") {
                var array = [dummyObj1, dummyObj6, dummyObj6, dummyObj2, dummyObj3, dummyObj6, dummyObj4, dummyObj5, dummyObj6]
                array.removeAllInstances(dummyObj6)
                expect(array).to(equal([dummyObj1, dummyObj2, dummyObj3, dummyObj4, dummyObj5]))
            }
        }
    }
    // swiftlint:enable function_body_length
}
