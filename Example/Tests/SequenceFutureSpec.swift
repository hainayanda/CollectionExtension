//
//  SequenceFutureSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension
import Combine

class SequenceFutureSpec: QuickSpec {
    
    // swiftlint:disable function_body_length cyclomatic_complexity
    override class func spec() {
        it("should foreach all aynchronously") {
            let future = [1, 2, 3, 4, 5].futureForEach { _ in
                try await Task.sleep(nanoseconds: 1000000)
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success:
                break
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
        it("should foreach all aynchronously and throw error") {
            let future = [1, 2, 3, 4, 5].futureForEach { number in
                if number % 2 == 0 {
                    throw TestError.expectedError
                }
                try await Task.sleep(nanoseconds: 1000000)
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success:
                fail("should produce error")
            case .failure(let failure):
                expect(failure as? TestError).to(equal(.expectedError))
            }
        }
        it("should foreach all aynchronously while ignoring error") {
            let future = [1, 2, 3, 4, 5].futureForEachIgnoreError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1000000)
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success:
                break
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
        it("should map all aynchronously") {
            let future = [1, 2, 3, 4, 5].futureMap { number in
                try await Task.sleep(nanoseconds: 1000000)
                return number.description
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success(let mapped):
                expect(mapped).to(equal(["1", "2", "3", "4", "5"]))
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
        it("should map all aynchronously and throw error") {
            let future = [1, 2, 3, 4, 5].futureMap { number in
                if number % 2 == 0 {
                    throw TestError.expectedError
                }
                try await Task.sleep(nanoseconds: 1000000)
                return number.description
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success:
                fail("should produce error")
            case .failure(let failure):
                expect(failure as? TestError).to(equal(.expectedError))
            }
        }
        it("should map all aynchronously while ignoring error") {
            let future = [1, 2, 3, 4, 5].futureMapSkipError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1000000)
                return number.description
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success(let mapped):
                expect(mapped).to(equal(["1", "3", "5"]))
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
        it("should compact map all aynchronously") {
            let future = [1, 2, 3, 4, 5].futureCompactMap { number in
                try await Task.sleep(nanoseconds: 1000000)
                return number == 3 ? nil: number.description
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success(let mapped):
                expect(mapped).to(equal(["1", "2", "4", "5"]))
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
        it("should compact map all aynchronously and throw error") {
                let future = [1, 2, 3, 4, 5].futureCompactMap { number in
                    if number % 2 == 0 {
                        throw TestError.expectedError
                    }
                    try await Task.sleep(nanoseconds: 1000000)
                    return number == 3 ? nil: number.description
                }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success:
                fail("should produce error")
            case .failure(let failure):
                expect(failure as? TestError).to(equal(.expectedError))
            }
        }
        it("should compact map all aynchronously while ignoring error") {
            let future = [1, 2, 3, 4, 5].futureCompactMapSkipError { number in
                if number % 2 == 0 {
                    throw TestError.unexpectedError
                }
                try await Task.sleep(nanoseconds: 1000000)
                return number == 3 ? nil: number.description
            }
            guard let result = waitUntilFinished(future) else {
                fail("should produce result")
                return
            }
            switch result {
            case .success(let mapped):
                expect(mapped).to(equal(["1", "5"]))
            case .failure(let failure):
                fail("should not produce error \(failure)")
            }
        }
    }
    // swiftlint:enable function_body_length cyclomatic_complexity
}

@discardableResult
func waitUntilFinished<S, F: Error>(_ future: Future<S, F>) -> Result<S, F>? {
    var result: Result<S, F>?
    var cancellable: AnyCancellable?
    waitUntil { done in
        cancellable = future.sink { completion in
            switch completion {
            case .failure(let error):
                result = .failure(error)
            case .finished:
                break
            }
            cancellable?.cancel()
            cancellable = nil
            done()
        } receiveValue: { value in
            result = .success(value)
        }
    }
    return result
}
