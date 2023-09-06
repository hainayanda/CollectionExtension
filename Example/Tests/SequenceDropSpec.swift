//
//  SequenceDropSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceDropSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        let dummy1 = DummyObject()
        let dummy2 = DummyObject()
        let dummy3 = DummyObject()
        let dummy4 = DummyObject()
        let dummy5 = DummyObject()
        context("regular sequence") {
            it("should drop all until element found") {
                let array = [1, 2, 3, 4, 5].dropAllUntil { $0 == 3 }
                let expected = [3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [1, 2, 3, 4, 5].dropAllUntil { $0 == 6 }
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [1, 2, 3, 4, 5].dropAllAfter { $0 == 3 }
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [1, 2, 3, 4, 5].dropAllAfter { $0 == 6 }
                let expected = [1, 2, 3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should drop all until element found") {
                let array = [1, 2, 3, 4, 5].dropAllUntil(find: 3)
                let expected = [3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [1, 2, 3, 4, 5].dropAllUntil(find: 6)
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [1, 2, 3, 4, 5].dropAllAfter(find: 3)
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [1, 2, 3, 4, 5].dropAllAfter(find: 6)
                let expected = [1, 2, 3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should drop all until element found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].dropAllUntil(findInstance: dummy3)
                let expected = [dummy3, dummy4, dummy5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].dropAllUntil(findInstance: DummyObject())
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].dropAllAfter(findInstance: dummy3)
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].dropAllAfter(findInstance: DummyObject())
                let expected = [dummy1, dummy2, dummy3, dummy4, dummy5]
                expect(array).to(equal(expected))
            }
        }
        context("lazy sequence") {
            it("should drop all until element found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllUntil { $0 == 3 }.toArray()
                let expected = [3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllUntil { $0 == 6 }.toArray()
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllAfter { $0 == 3 }.toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllAfter { $0 == 6 }.toArray()
                let expected = [1, 2, 3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should drop all until element found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllUntil(find: 3).toArray()
                let expected = [3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [1, 2, 3, 4, 5].dropAllUntil(find: 6).toArray()
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllAfter(find: 3).toArray()
                let expected = [1, 2, 3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [1, 2, 3, 4, 5].lazy.dropAllAfter(find: 6).toArray()
                let expected = [1, 2, 3, 4, 5]
                expect(array).to(equal(expected))
            }
            it("should drop all until element found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.dropAllUntil(findInstance: dummy3).toArray()
                let expected = [dummy3, dummy4, dummy5]
                expect(array).to(equal(expected))
            }
            it("should not drop all if element not found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.dropAllUntil(findInstance: DummyObject()).toArray()
                expect(array.isEmpty).to(beTrue())
            }
            it("should drop all after element found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.dropAllAfter(findInstance: dummy3).toArray()
                let expected = [dummy1, dummy2, dummy3]
                expect(array).to(equal(expected))
            }
            it("should not drop if element not found") {
                let array = [dummy1, dummy2, dummy3, dummy4, dummy5].lazy.dropAllAfter(findInstance: DummyObject()).toArray()
                let expected = [dummy1, dummy2, dummy3, dummy4, dummy5]
                expect(array).to(equal(expected))
            }
        }
        
    }
    // swiftlint:enable function_body_length
}
