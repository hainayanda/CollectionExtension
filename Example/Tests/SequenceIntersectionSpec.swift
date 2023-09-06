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
    
    // swiftlint:disable function_body_length
    override class func spec() {
        context("regular sequence") {
            it("should intersect based on projection") {
                let left: [Dummy] = .dummies(count: Int.random(in: 20..<50))
                let expected: [Dummy] = Array(left[0..<15])
                let right: [Dummy] = expected + [Dummy].dummies(count: Int.random(in: 10 ..< 20))
                let intersection = left.intersect(with: right) { $0.uuid }
                expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
            }
            it("should intersect based on keypath") {
                let left: [Dummy] = .dummies(count: Int.random(in: 20..<50))
                let expected: [Dummy] = Array(left[0..<15])
                let right: [Dummy] = expected + [Dummy].dummies(count: Int.random(in: 10 ..< 20))
                let intersection = left.intersect(with: right, by: \.uuid)
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
        context("lazy sequence") {
            it("should intersect based on projection") {
                let left: LazySequence<[Dummy]> = [Dummy].dummies(count: Int.random(in: 20..<50)).lazy
                let expected: [Dummy] = Array(left[0..<15])
                let right: LazySequence<[Dummy]> = (expected + [Dummy].dummies(count: Int.random(in: 10 ..< 20))).lazy
                let intersection = left.intersect(with: right) { $0.uuid }.toArray()
                expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
            }
            it("should intersect based on keypath") {
                let left: LazySequence<[Dummy]> = [Dummy].dummies(count: Int.random(in: 20..<50)).lazy
                let expected: [Dummy] = Array(left[0..<15])
                let right: LazySequence<[Dummy]> = (expected + [Dummy].dummies(count: Int.random(in: 10 ..< 20))).lazy
                let intersection = left.intersect(with: right, by: \.uuid).toArray()
                expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
            }
            it("should intersect equatables") {
                let left: LazySequence<[DummyEquatable]> = [DummyEquatable].dummies(count: Int.random(in: 20..<50)).lazy
                let expected: [DummyEquatable] = Array(left[0..<15])
                let right: LazySequence<[DummyEquatable]> = (expected + [DummyEquatable].dummies(count: Int.random(in: 10 ..< 20))).lazy
                let intersection = left.intersect(with: right).toArray()
                expect(intersection).to(equal(expected))
            }
            it("should intersect hashables") {
                let left: LazySequence<[DummyHashable]> = [DummyHashable].dummies(count: Int.random(in: 20..<50)).lazy
                let expected: [DummyHashable] = Array(left[0..<15])
                let right: LazySequence<[DummyHashable]> = (expected + [DummyHashable].dummies(count: Int.random(in: 10 ..< 20))).lazy
                let intersection = left.intersect(with: right).toArray()
                expect(intersection).to(equal(expected))
            }
            it("should intersect objects") {
                let left: LazySequence<[DummyObject]> = [DummyObject].dummies(count: Int.random(in: 20..<50)).lazy
                let expected: [DummyObject] = Array(left[0..<15])
                let right: LazySequence<[DummyObject]> = (expected + [DummyObject].dummies(count: Int.random(in: 10 ..< 20))).lazy
                let intersection = left.intersectInstances(with: right).toArray()
                expect(intersection.compactMap { $0.uuid }).to(equal(expected.compactMap { $0.uuid }))
            }
        }
    }
    // swiftlint:enable function_body_length
}
