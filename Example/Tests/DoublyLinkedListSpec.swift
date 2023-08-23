//
//  DoublyLinkedListSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class DoublyLinkedListSpec: QuickSpec {
    // swiftlint:disable function_body_length
    override class func spec() {
        var array: [DummyEquatable]!
        var linkedList: DoublyLinkedList<DummyEquatable>!
        beforeEach {
            array = .dummies(count: 10)
            linkedList = .init(array)
        }
        it("should get using subscript") {
            expect(linkedList.count).to(equal(array.count))
            array.enumerated().forEach { index, dummy in
                expect(linkedList[index]).to(equal(dummy))
            }
        }
        it("should get node at given index") {
            array.enumerated().forEach { index, element in
                expect(linkedList.node(at: index)?.element).to(equal(element))
            }
        }
        it("should append node") {
            let node = linkedList.firstNode!
            linkedList.append(node: node)
            expect(linkedList.last).to(equal(node.element))
            expect(linkedList.first).toNot(equal(node.element))
        }
        it("should append element") {
            for _ in 0..<10 {
                let element = DummyEquatable()
                linkedList.append(element)
                expect(linkedList.last).to(equal(element))
            }
        }
        it("should append elements") {
            let expected = array + array
            linkedList.append(contentsOf: array)
            expect(Array(linkedList)).to(equal(expected))
        }
        it("should insert element") {
            let newElement = DummyEquatable()
            linkedList.insert(newElement, at: 9)
            expect(linkedList.lastNode?.previous?.element).to(equal(newElement))
            linkedList.insert(newElement, at: 1)
            expect(linkedList.firstNode?.next?.element).to(equal(newElement))
        }
        it("should insert node") {
            let firstNode = linkedList.firstNode!
            linkedList.insert(node: firstNode, at: 9)
            expect(linkedList.lastNode).to(equal(firstNode))
        }
        it("should insert elements") {
            let expected = Array(array[0..<5]) + array + Array(array[5..<10])
            linkedList.insert(contentsOf: array, at: 5)
            expect(Array(linkedList)).to(equal(expected))
        }
        it("should insert nothing") {
            linkedList.insert(contentsOf: [], at: 5)
            expect(Array(linkedList)).to(equal(array))
        }
        it("should just append") {
            let expected = array + array
            linkedList.insert(contentsOf: array, at: 10)
            expect(Array(linkedList)).to(equal(expected))
        }
        it("should remove node") {
            let firstNode = linkedList.firstNode!
            expect(linkedList.remove(node: firstNode)).to(beTrue())
            expect(linkedList.count).to(equal(9))
            expect(linkedList.firstNode).toNot(equal(firstNode))
            expect(linkedList.remove(node: firstNode)).to(beFalse())
            expect(linkedList.count).to(equal(9))
            expect(linkedList.firstNode).toNot(equal(firstNode))
        }
        it("should remove at position") {
            let element = linkedList.remove(at: 9)!
            expect(linkedList.count).to(equal(9))
            expect(linkedList.last).toNot(equal(element))
        }
        it("should remove nothing") {
            expect(linkedList.remove(at: 10)).to(beNil())
            expect(linkedList.count).to(equal(10))
        }
        it("should remove first") {
            let first = linkedList.first!
            expect(linkedList.removeFirst()).to(equal(first))
            expect(linkedList.count).to(equal(9))
            expect(linkedList.first).toNot(equal(first))
        }
        it("should remove last") {
            let last = linkedList.last!
            expect(linkedList.removeLast()).to(equal(last))
            expect(linkedList.count).to(equal(9))
            expect(linkedList.last).toNot(equal(last))
        }
        it("should remove all found") {
            let expected = [array[1], array[3], array[5], array[7], array[9]]
            var int = 0
            linkedList.removeAll { _ in
                defer { int += 1 }
                return int % 2 == 0
            }
            expect(Array(linkedList)).to(equal(expected))
        }
        it("should remove all") {
            linkedList.removeAll()
            expect(linkedList.isEmpty).to(beTrue())
        }
    }
    // swiftlint:enable function_body_length
}
