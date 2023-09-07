//
//  CollectionExtensionSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class CollectionExtensionSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        context("common") {
            let sequence = DoublyLinkedList([1, 2, 3])
            it("it should get element when index is in bounds") {
                expect(sequence[safe: 1]).to(equal(2))
            }
            it("it should get nil when index is out  of bounds") {
                expect(sequence[safe: 3]).to(beNil())
            }
            it("it should return true if its not empty") {
                expect([1, 2, 3].isNotEmpty).to(beTrue())
            }
            it("it should return false if its empty") {
                expect([Int]().isNotEmpty).to(beFalse())
            }
        }
        context("int") {
            let arrayEven: [Int] = [5, 4, 3, 1, 6, 5, 2, 1]
            let arrayOdd: [Int] = [5, 4, 3, 1, 5, 2, 1]
            it("should find an even median") {
                let sorted = arrayEven.sorted()
                expect(sorted.median).to(equal(.double(3, 4)))
                expect(sorted.median.value).to(equal(3.5))
            }
            it("should find an odd median") {
                let sorted = arrayOdd.sorted()
                expect(sorted.median).to(equal(.single(3)))
                expect(sorted.median.value).to(equal(3))
            }
            it("should return none when empty") {
                expect([Int]().median).to(equal(.noMedian))
                expect([Int]().median.value).to(beNil())
            }
        }
        context("double") {
            let arrayEven: [Double] = [5, 4, 3, 1, 6, 5, 2, 1]
            let arrayOdd: [Double] = [5, 4, 3, 1, 5, 2, 1]
            it("should find an even median") {
                let sorted = arrayEven.sorted()
                expect(sorted.median).to(equal(.double(3, 4)))
                expect(sorted.median.value).to(equal(3.5))
            }
            it("should find an odd median") {
                let sorted = arrayOdd.sorted()
                expect(sorted.median).to(equal(.single(3)))
                expect(sorted.median.value).to(equal(3))
            }
            it("should return none when empty") {
                expect([Double]().median).to(equal(.noMedian))
                expect([Double]().median.value).to(beNil())
            }
        }
        it("should return single median when array is have just one value") {
            expect([1].median).to(equal(.single(1)))
            expect([1].median.value).to(equal(1))
        }
        it("should sum every element") {
            expect([2, 1, 4, 5, 3].sum).to(equal(15))
        }
        it("should get average of every element") {
            expect([2, 1, 4, 5, 3].average).to(equal(3))
        }
        it("should get average of every element") {
            expect([2.0, 1.0, 4.0, 5.0, 3.0].average).to(equal(3.0))
        }
        it("should get smallest element") {
            expect([2, 1, 4, 5, 3].smallest).to(equal(1))
        }
        it("should get biggest element") {
            expect([2, 1, 4, 5, 3].biggest).to(equal(5))
        }
        it("should get modus of element") {
            expect([1, 2, 2, 3, 3, 3, 4, 5, 5].modus).to(equal(3))
        }
        it("should get modus of element") {
            expect([1, 2, 2, 3, 3, 3, 4, 5, 5].modus(where: ==)).to(equal(3))
        }
        it("should get modus of objects") {
            let obj1 = DummyObject()
            let obj2 = DummyObject()
            let obj3 = DummyObject()
            let obj4 = DummyObject()
            let obj5 = DummyObject()
            expect([obj1, obj2, obj2, obj3, obj3, obj3, obj4, obj5, obj5].modusInstances).to(equal(obj3))
        }
        it("should get modus using keypath") {
            let obj1 = DummyObject()
            let obj2 = DummyObject()
            let obj3 = DummyObject()
            let obj4 = DummyObject()
            let obj5 = DummyObject()
            expect([obj1, obj2, obj2, obj3, obj3, obj3, obj4, obj5, obj5].modus(by: \.uuid)).to(equal(obj3))
        }
        it("should get modus for equatable") {
            let obj1 = DummyEquatable()
            let obj2 = DummyEquatable()
            let obj3 = DummyEquatable()
            let obj4 = DummyEquatable()
            let obj5 = DummyEquatable()
            expect([obj1, obj2, obj2, obj3, obj3, obj3, obj4, obj5, obj5].modus).to(equal(obj3))
        }
        it("should group by frequency") {
            expect([1, 2, 2, 3, 3, 3, 4, 5, 5].groupedByFrequency())
                .to(equal([1: 1, 2: 2, 3: 3, 4: 1, 5: 2]))
        }
        it("should group by frequency using comparator") {
            expect([1, 2, 2, 3, 3, 3, 4, 5, 5].groupedByFrequency(where: ==))
                .to(equal([.init(1, count: 1), .init(2, count: 2), .init(3, count: 3), .init(4, count: 1), .init(5, count: 2)]))
        }
        it("should group by frequency using projection") {
            expect([1, 2, 2, 3, 3, 3, 4, 5, 5].groupedByFrequency(using: { $0 }))
                .to(equal([.init(1, count: 1), .init(2, count: 2), .init(3, count: 3), .init(4, count: 1), .init(5, count: 2)]))
        }
        it("should get modus of objects") {
            let obj1 = DummyObject()
            let obj2 = DummyObject()
            let obj3 = DummyObject()
            let obj4 = DummyObject()
            let obj5 = DummyObject()
            let array = [obj1, obj2, obj2, obj3, obj3, obj3, obj4, obj5, obj5]
            expect(array.groupedInstancesByFrequency())
                .to(equal([.init(obj1, count: 1), .init(obj2, count: 2), .init(obj3, count: 3), .init(obj4, count: 1), .init(obj5, count: 2)]))
            expect(array.instanceCount(obj3)).to(equal(3))
        }
        it("should get modus of objects") {
            let obj1 = DummyEquatable()
            let obj2 = DummyEquatable()
            let obj3 = DummyEquatable()
            let obj4 = DummyEquatable()
            let obj5 = DummyEquatable()
            let array = [obj1, obj2, obj2, obj3, obj3, obj3, obj4, obj5, obj5]
            expect(array.groupedByFrequency())
                .to(equal([.init(obj1, count: 1), .init(obj2, count: 2), .init(obj3, count: 3), .init(obj4, count: 1), .init(obj5, count: 2)]))
            expect(array.elementCount(obj3)).to(equal(3))
        }
    }
    // swiftlint:enable function_body_length
}
