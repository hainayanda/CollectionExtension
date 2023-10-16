//
//  SequenceAsyncAwaitSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceAsyncAwaitSpec: AsyncSpec {
    
    // swiftlint:disable function_body_length cyclomatic_complexity
    override class func spec() {
        it("should foreach all aynchronously") {
            let counter = AtomicCounter(0)
            try await [1, 2, 3, 4, 5].asyncForEach { number in
                try await Task.sleep(nanoseconds: 1_000_000)
                await counter.add(number)
            }
            let value = await counter.value
            expect(value).to(equal(15))
        }
        it("should foreach all aynchronously before timeout reach") {
            let counter = AtomicCounter(0)
            try await [1, 2, 3, 4, 5].asyncForEach(timeout: 0.01) { number in
                try await Task.sleep(nanoseconds: UInt64(1_000_000 * number))
                await counter.add(number)
            }
            let value = await counter.value
            expect(value).to(equal(15))
        }
        it("should foreach all aynchronously until timeout reach") {
            let counter = AtomicCounter(0)
            do {
                try await [1, 2, 3, 4, 5].asyncForEach(timeout: 0.0001) { number in
                    try await Task.sleep(nanoseconds: UInt64(1_000_000 * number))
                    await counter.add(1)
                }
                fail("it should be fail at this point")
            } catch {
                let value = await counter.value
                expect(value).to(beLessThan(5))
            }
        }
        it("should foreach all aynchronously and throw error") {
            let counter = AtomicCounter(0)
            do {
                try await [1, 2, 3, 4, 5].asyncForEach { number in
                    if number % 2 == 0 {
                        throw TestError.expectedError
                    }
                    try await Task.sleep(nanoseconds: 1_000_000)
                    await counter.add(number)
                }
                fail("error should be thrown")
            } catch {
                expect(error as? TestError).to(equal(TestError.expectedError))
            }
            let value = await counter.value
            expect(value).to(equal(0))
        }
        it("should foreach all aynchronously while ignoring error") {
            let counter = AtomicCounter(0)
            await [1, 2, 3, 4, 5].asyncForEachIgnoreError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1_000_000)
                await counter.add(number)
            }
            let value = await counter.value
            expect(value).to(equal(9))
        }
        it("should map all aynchronously") {
            let result = try await [1, 2, 3, 4, 5].asyncMap { number in
                try await Task.sleep(nanoseconds: 1_000_000)
                return number.description
            }
            expect(result).to(equal(["1", "2", "3", "4", "5"]))
        }
        it("should map all aynchronously before timeout") {
            let result = try await [1, 2, 3, 4, 5].asyncMap(timeout: 0.01) { number in
                try await Task.sleep(nanoseconds: UInt64(1_000_000 * number))
                return number.description
            }
            expect(result).to(equal(["1", "2", "3", "4", "5"]))
        }
        it("should map all aynchronously until timeout") {
            let counter = AtomicCounter(0)
            do {
                let result = try await [1, 2, 3, 4, 5].asyncMap(timeout: 0.0001) { number in
                    try await Task.sleep(nanoseconds: UInt64(1_000_000 * number))
                    await counter.add(1)
                    return number.description
                }
                fail("it should be fail at this point")
            } catch {
                let value = await counter.value
                expect(value).to(beLessThan(5))
            }
        }
        it("should map all aynchronously and throw error") {
            do {
                _ = try await [1, 2, 3, 4, 5].asyncMap { number in
                    if number % 2 == 0 {
                        throw TestError.expectedError
                    }
                    try await Task.sleep(nanoseconds: 1_000_000)
                    return number.description
                }
                fail("error should be thrown")
            } catch {
                expect(error as? TestError).to(equal(TestError.expectedError))
            }
        }
        it("should map all aynchronously while ignoring error") {
            let result = await [1, 2, 3, 4, 5].asyncMapSkipError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1_000_000)
                return number.description
            }
            expect(result).to(equal(["1", "3", "5"]))
        }
        it("should compact map all aynchronously") {
            let result = try await [1, 2, 3, 4, 5].asyncCompactMap { number in
                try await Task.sleep(nanoseconds: 1_000_000)
                return number == 3 ? nil: number.description
            }
            expect(result).to(equal(["1", "2", "4", "5"]))
        }
        it("should compact map all aynchronously and throw error") {
            do {
                _ = try await [1, 2, 3, 4, 5].asyncCompactMap { number in
                    if number % 2 == 0 {
                        throw TestError.expectedError
                    }
                    try await Task.sleep(nanoseconds: 1_000_000)
                    return number == 3 ? nil: number.description
                }
                fail("error should be thrown")
            } catch {
                expect(error as? TestError).to(equal(TestError.expectedError))
            }
        }
        it("should compact map all aynchronously while ignoring error") {
            let result = await [1, 2, 3, 4, 5].asyncCompactMapSkipError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1_000_000)
                return number == 3 ? nil: number.description
            }
            expect(result).to(equal(["1", "5"]))
        }
        it("should compact map all aynchronously while ignoring timeout") {
            let result = await [1, 2, 3, 4, 5].asyncCompactMapSkipError(timeout: 0.001) { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: UInt64(1_000_000 * number))
                return number == 3 ? nil: number.description
            }
            expect(result.count).to(beLessThan(2))
        }
    }
    // swiftlint:enable function_body_length cyclomatic_complexity
}

actor AtomicCounter {
    var value: Int
    
    init(_ value: Int) {
        self.value = value
    }
    
    func add(_ value: Int) {
        self.value += value
    }
}
