//
//  Sequence+AsyncAwait.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 6/9/23.
//

import Foundation
import Combine

// MARK: Map

extension Sequence {
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished
    /// It will run the closure asynchronously and throwing error if one of the closure is failing.
    /// - Parameter doTask: Asynchronous task to be run on each iteration
    public func asyncForEach(_ doTask: @Sendable @escaping (Element) async throws -> Void) async rethrows {
        try await withThrowingTaskGroup(of: Void.self, returning: Void.self) { group in
            for element in self {
                group.addTask { try await doTask(element) }
            }
            do {
                while let _ = try await group.next() {
                    // no error
                }
            } catch {
                group.cancelAll()
                throw error
            }
        }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished
    /// It will run the closure asynchronously and throwing error if one of the closure is failing or reach a timeout.
    /// - Parameters:
    ///   - timeout: Timeout of the whole for each tasks
    ///   - doTask: Asynchronous task to be run on each iteration
    public func asyncForEach(timeout: TimeInterval, _ doTask: @Sendable @escaping (Element) async throws -> Void) async throws {
        try await withTimeout(timeout: timeout) {
            try await self.asyncForEach(doTask)
        }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished while ignoring the error throws
    /// - Parameter doTask: Asynchronous task to be run on each iteration
    public func asyncForEachIgnoreError(_ doTask: @Sendable @escaping (Element) async throws -> Void) async {
        await asyncForEach { element in
            try? await doTask(element)
        }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished while ignoring the error throws
    /// It will run the closure asynchronously and stop when all task is finished or when reach a timeout.
    /// - Parameters:
    ///   - timeout: Timeout of the whole for each tasks
    ///   - doTask: Asynchronous task to be run on each iteration
    public func asyncForEachIgnoreError(timeout: TimeInterval, _ doTask: @Sendable @escaping (Element) async throws -> Void) async {
        try? await withTimeout(timeout: timeout) {
            await self.asyncForEachIgnoreError(doTask)
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncMap<Mapped>(_ mapper: @Sendable @escaping (Element) async throws -> Mapped) async rethrows -> [Mapped] {
        try await withThrowingTaskGroup(of: (Int, Mapped).self, returning: [Mapped].self) { group in
            var results: [(Int, Mapped)] = []
            for (index, element) in self.enumerated() {
                group.addTask { return (index, try await mapper(element))}
            }
            do {
                while let result = try await group.next() {
                    results.append(result)
                }
                return results.sorted { $0.0 < $1.0 }
                    .map { $0.1 }
            } catch {
                group.cancelAll()
                throw error
            }
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure or when its reach a timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole map tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncMap<Mapped>(timeout: TimeInterval, _ mapper: @Sendable @escaping (Element) async throws -> Mapped) async throws -> [Mapped] {
        try await withTimeout(timeout: timeout) {
            try await self.asyncMap(mapper)
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring mapper that throws an error.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncMapSkipError<Mapped>(_ mapper: @Sendable @escaping (Element) async throws -> Mapped) async -> [Mapped] {
        await asyncCompactMap { try? await mapper($0) }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring mapper that throws an error.
    /// It will stop the mapping execution if its reach a timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole map tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncMapSkipError<Mapped>(timeout: TimeInterval, _ mapper: @Sendable @escaping (Element) async throws -> Mapped) async -> [Mapped] {
        await asyncCompactMapSkipError(timeout: timeout, { try? await mapper($0) })
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncCompactMap<Mapped>(_ mapper: @Sendable @escaping (Element) async throws -> Mapped?) async rethrows -> [Mapped] {
        try await withThrowingTaskGroup(of: (Int, Mapped?).self, returning: [Mapped].self) { group in
            var results: [(Int, Mapped?)] = []
            for (index, element) in self.enumerated() {
                group.addTask { return (index, try await mapper(element))}
            }
            do {
                while let result = try await group.next() {
                    results.append(result)
                }
                return results.sorted { $0.0 < $1.0 }
                    .compactMap { $0.1 }
            }
            catch {
                group.cancelAll()
                throw error
            }
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure or when its reach a timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole map tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncCompactMap<Mapped>(timeout: TimeInterval, _ mapper: @Sendable @escaping (Element) async throws -> Mapped?) async throws -> [Mapped] {
        try await withTimeout(timeout: timeout) {
            try await self.asyncCompactMap(mapper)
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and ignore the error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncCompactMapSkipError<Mapped>(_ mapper: @Sendable @escaping (Element) async throws -> Mapped?) async -> [Mapped] {
        await asyncCompactMap { try? await mapper($0) }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and ignore the error if one of the element is failing in the given async closure.
    /// It will stop the mapping execution if its reach a timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole map tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncCompactMapSkipError<Mapped>(timeout: TimeInterval, _ mapper: @Sendable @escaping (Element) async throws -> Mapped?) async -> [Mapped] {
        await withThrowingTaskGroup(of: (Int, Mapped?).self, returning: [Mapped].self) { group in
            var results: [(Int, Mapped?)] = []
            for (index, element) in self.enumerated() {
                group.addTask { return (index, try? await mapper(element))}
            }
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw CollectionExtensionError.timeOut
            }
            do {
                while let result = try await group.next() {
                    results.append(result)
                }
            } catch {
                // reaching timeout
            }
            group.cancelAll()
            return results.sorted { $0.0 < $1.0 }
                .compactMap { $0.1 }
        }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished
    /// It will run the closure asynchronously and throwing error if one of the closure is failing.
    /// - Parameter doTask: Asynchronous task to be run on each iteration
    /// - Returns: A publisher that run after all the task is finished
    public func futureForEach(_ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Error> {
        futureTask { try await self.asyncForEach(doTask) }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished
    /// It will run the closure asynchronously and throwing error if one of the closure is failing or when its reach timeout.
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - doTask: Asynchronous task to be run on each iteration
    /// - Returns: A publisher that run after all the task is finished
    public func futureForEach(timeout: TimeInterval, _ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Error> {
        futureTask { try await self.asyncForEach(timeout: timeout, doTask) }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished while ignoring the error throws
    /// - Parameter doTask: Asynchronous task to be run on each iteration
    /// - Returns: A publisher that run after all the task is finished
    public func futureForEachIgnoreError(_ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Never> {
        futureTask { await self.asyncForEachIgnoreError(doTask) }
    }
    
    /// Calls the given closure on each element in the sequence in the same order asynchronously and wait for all to finished while ignoring the error throws
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - doTask: Asynchronous task to be run on each iteration
    /// - Returns: A publisher that run after all the task is finished
    public func futureForEachIgnoreError(timeout: TimeInterval, _ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Never> {
        futureTask { await self.asyncForEachIgnoreError(timeout: timeout, doTask) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        futureTask { try await self.asyncMap(mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure or when its reach timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureMap<Mapped>(timeout: TimeInterval, _ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        futureTask { try await self.asyncMap(timeout: timeout, mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and ignoring the error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        futureTask { await self.asyncMapSkipError(mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and ignoring the error if one of the element is failing in the given async closure and stop when its reach timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureMapSkipError<Mapped>(timeout: TimeInterval, _ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        futureTask { await self.asyncMapSkipError(timeout: timeout, mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureCompactMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        futureTask { try await self.asyncCompactMap(mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure or when its reach timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureCompactMap<Mapped>(timeout: TimeInterval, _ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        futureTask { try await self.asyncCompactMap(timeout: timeout, mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and ignore the error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureCompactMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        futureTask { await self.asyncCompactMapSkipError(mapper) }
    }
    
    /// Returns Future with output array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and ignore the error if one of the element is failing in the given async closure and stop when its reach timeout.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: Timeout of the whole tasks
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureCompactMapSkipError<Mapped>(timeout: TimeInterval, _ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        futureTask { await self.asyncCompactMapSkipError(timeout: timeout, mapper) }
    }
    
    // MARK: Private methods
    
    private func withTimeout<Result>(timeout: TimeInterval, _ task: @Sendable @escaping () async throws -> Result) async throws -> Result {
        try await withThrowingTaskGroup(of: Result.self, returning: Result.self) { group in
            group.addTask { try await task() }
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw CollectionExtensionError.timeOut
            }
            do {
                let result = try await group.next()
                group.cancelAll()
                guard let result else {
                    // this is unlikely to happen
                    throw CollectionExtensionError.failedToProduceResult
                }
                return result
            } catch {
                // cancel other task, it might producing a timeout
                group.cancelAll()
                throw error
            }
        }
    }
}

// MARK: Private function

private func futureTask<Output>(_ task: @escaping () async throws -> Output) -> Future<Output, Error> {
    Future { promise in
        Task {
            do {
                try await promise(.success(task()))
            } catch {
                promise(.failure(error))
            }
        }
    }
}

private func futureTask<Output>(_ task: @escaping () async -> Output) -> Future<Output, Never> {
    Future { promise in
        Task {
            await promise(.success(task()))
        }
    }
}
