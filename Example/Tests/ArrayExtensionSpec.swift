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
        it("should create new array with added element") {
            let array = [1, 2]
            expect(array.added(with: 3)).to(equal([1, 2, 3]))
        }
        it("should create new array with added elements") {
            let array = [1, 2]
            expect(array.added(withContentsOf: [3, 4, 5])).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added element at given index") {
            let array = [1, 2]
            expect(array.inserted(with: 3, at: 0)).to(equal([3, 1, 2]))
        }
        it("should create new array with added elements at given index") {
            let array = [1, 2]
            expect(array.inserted(withContentsOf: [3, 4, 5], at: 0)).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added unique element") {
            let array = [1, 2]
            expect(array.addedIfDistinct(with: 3)).to(equal([1, 2, 3]))
            expect(array.addedIfDistinct(with: 2)).to(equal([1, 2]))
        }
        it("should create new array with added unique elements") {
            let array = [1, 2]
            expect(array.addedAllDistinct(in: [2, 3, 4, 5])).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added unique element at given index") {
            let array = [1, 2]
            expect(array.insertedIfDistinct(with: 3, at: 0)).to(equal([3, 1, 2]))
            expect(array.insertedIfDistinct(with: 1, at: 0)).to(equal([1, 2]))
        }
        it("should create new array with added unique elements at given index") {
            let array = [1, 2]
            expect(array.insertedAllDistinct(in: [2, 3, 4, 5], at: 0)).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added unique object") {
            let object1 = MyObject()
            let object2 = MyObject()
            let array = [object1]
            expect(array.addedIfDistinctInstance(with: object2)).to(equal([object1, object2]))
            expect(array.addedIfDistinctInstance(with: object1)).to(equal([object1]))
        }
        it("should create new array with added unique objects") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.addedAllDistinctInstances(in: [object2, object2, object3, object3, object4])).to(equal([object1, object2, object3, object3, object4]))
        }
        it("should create new array with added unique object at given index") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let array = [object1, object2]
            expect(array.insertedIfDistinctInstance(with: object3, at: 0)).to(equal([object3, object1, object2]))
            expect(array.insertedIfDistinctInstance(with: object2, at: 0)).to(equal([object1, object2]))
        }
        it("should create new array with added unique objects at given index") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.insertedAllDistinctInstances(in: [object2, object2, object3, object3, object4], at: 0)).to(equal([object3, object3, object4, object1, object2]))
        }
        it("should removed element at given index") {
            let array = [1, 2, 3]
            expect(array.removed(at: 1)).to(equal([1, 3]))
        }
        it("should removed element found") {
            let array = [1, 2, 3]
            expect(array.removedAll(2)).to(equal([1, 3]))
            expect(array.removedAll(4)).to(equal([1, 2, 3]))
        }
        it("should removed elements found") {
            let array = [1, 2, 3, 4, 5]
            expect(array.removedAll(in: [4, 5, 6])).to(equal([1, 2, 3]))
        }
        it("should removed element instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2, object3]
            expect(array.removedAllInstances(object2)).to(equal([object1, object3]))
            expect(array.removedAllInstances(object4)).to(equal([object1, object2, object3]))
        }
        it("should removed elements instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2, object3]
            expect(array.removedAllInstances(in: [object3, object4])).to(equal([object1, object2]))
        }
    }
    // swiftlint:enable function_body_length
}

private class MyObject: Equatable {
    let id: String = UUID().uuidString
    
    static func == (lhs: MyObject, rhs: MyObject) -> Bool {
        lhs.id == rhs.id
    }
}
