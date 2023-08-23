//
//  SequenceIntersectionSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceIntersectionSpec: QuickSpec {
    
    override class func spec() {
        it("should intersect based on projection") {
            let left: [Dummy] = .dummies(count: Int.random(in: 20..<50))
            let expected: [Dummy] = Array(left[0..<15])
            let right: [Dummy] = expected + [Dummy].dummies(count: Int.random(in: 10 ..< 20))
            let intersection = left.intersect(with: right) { $0.uuid }
            expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
        }
        it("should intersect equatables") {
            let left: [DummyEquatable] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyEquatable] = Array(left[0..<15])
            let right: [DummyEquatable] = expected + [DummyEquatable].dummies(count: Int.random(in: 10 ..< 20))
            let intersection = left.intersect(with: right)
            expect(intersection).to(equal(expected))
        }
        it("should intersect hashables") {
            let left: [DummyHashable] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyHashable] = Array(left[0..<15])
            let right: [DummyHashable] = expected + [DummyHashable].dummies(count: Int.random(in: 10 ..< 20))
            let intersection = left.intersect(with: right)
            expect(intersection).to(equal(expected))
        }
        it("should intersect objects") {
            let left: [DummyObject] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyObject] = Array(left[0..<15])
            let right: [DummyObject] = expected + [DummyObject].dummies(count: Int.random(in: 10 ..< 20))
            let intersection = left.intersectInstances(with: right)
            expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
        }
    }
}
