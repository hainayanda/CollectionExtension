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
    
    public func asyncForEach(_ doTask: @escaping (Element) async throws -> Void) async rethrows {
        try await withThrowingTaskGroup(of: Void.self, returning: Void.self) { group in
            for element in self {
                group.addTask { try await doTask(element) }
            }
            try await group.waitForAll()
        }
    }
    
    public func asyncForEachIgnoreError(_ doTask: @escaping (Element) async throws -> Void) async {
        await asyncForEach { element in
            try? await doTask(element)
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: timeout in second, by default 30 seconds
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) async rethrows -> [Mapped] {
        try await withThrowingTaskGroup(of: (Int, Mapped).self, returning: [Mapped].self) { group in
            var results: [(Int, Mapped)] = []
            for (index, element) in self.enumerated() {
                group.addTask { return (index, try await mapper(element))}
            }
            while let result = try await group.next() {
                results.append(result)
            }
            return results.sorted { $0.0 < $1.0 }
                .map { $0.1 }
        }
    }
    
    public func asyncMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) async -> [Mapped] {
        await asyncCompactMap { try? await mapper($0) }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameters:
    ///   - timeout: timeout in second, by default 30 seconds
    ///   - mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///             and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: An array containing the transformed elements of this sequence
    public func asyncCompactMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) async rethrows -> [Mapped] {
        try await withThrowingTaskGroup(of: (Int, Mapped?).self, returning: [Mapped].self) { group in
            var results: [(Int, Mapped?)] = []
            for (index, element) in self.enumerated() {
                group.addTask { return (index, try await mapper(element))}
            }
            while let result = try await group.next() {
                results.append(result)
            }
            return results.sorted { $0.0 < $1.0 }
                .compactMap { $0.1 }
        }
    }
    
    public func asyncCompactMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) async -> [Mapped] {
        await asyncCompactMap { try? await mapper($0) }
    }
    
    public func futureForEach(_ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Error> {
        Future { promise in
            Task {
                do {
                    await promise(.success(try self.asyncForEach(doTask)))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func futureForEachIgnoreError(_ doTask: @escaping (Element) async throws -> Void) -> Future<Void, Error> {
        Future { promise in
            Task {
                await promise(.success(self.asyncForEachIgnoreError(doTask)))
            }
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns a transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        Future { promise in
            Task {
                do {
                    await promise(.success(try self.asyncMap(mapper)))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func futureMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped) -> Future<[Mapped], Error> {
        Future { promise in
            Task {
                await promise(.success(self.asyncMapSkipError(mapper)))
            }
        }
    }
    
    /// Returns an array containing the results of mapping the given async closure over the sequence's elements
    /// while ignoring `null` value.
    /// It will run asynchronously and throwing error if one of the element is failing in the given async closure.
    /// It will still retain the original order of the element regardless of the order of mapping time completion
    /// - Parameter mapper: A mapping async closure. `mapper` accepts an element of this sequence as its parameter
    ///   and returns an optional transformed value of the same or of a different type asynchronously.
    /// - Returns: A publisher that will produce an array containing the transformed elements of this sequence
    public func futureCompactMap<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        Future { promise in
            Task {
                do {
                    await promise(.success(try self.asyncCompactMap(mapper)))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func futureCompactMapSkipError<Mapped>(_ mapper: @escaping (Element) async throws -> Mapped?) -> Future<[Mapped], Error> {
        Future { promise in
            Task {
                await promise(.success(self.asyncCompactMapSkipError(mapper)))
            }
        }
    }
}
