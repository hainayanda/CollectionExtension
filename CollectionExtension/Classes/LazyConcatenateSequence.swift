//
//  LazyConcatenateSequence.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 1/9/23.
//

import Foundation

// MARK: LazyConcatenateSequence

/// Concantenated sequences into one lazy sequence
public struct LazyConcatenateSequence<Element>: LazySequenceProtocol {
    
    public typealias Iterator = LazyConcatenateIterator<Element>
    typealias IteratorNext = Iterator.IteratorNext
    
    let lazyIteratorsNextFactory: () -> [IteratorNext]
    
    init<S: Sequence>(sequences: [S]) where S.Element == Element {
        self.lazyIteratorsNextFactory = {
            sequences.map { sequence in
                var iterator = sequence.makeIterator()
                return { iterator.next() }
            }
        }
    }
    
    init<S1: Sequence, S2: Sequence>(_ s1: S1, _ s2: S2) where S1.Element == Element, S2.Element == Element {
        self.lazyIteratorsNextFactory = {
            var iterator1 = s1.makeIterator()
            var iterator2 = s2.makeIterator()
            return [
                { iterator1.next() },
                { iterator2.next() }
            ]
        }
    }
    
    public func makeIterator() -> Iterator {
        Iterator(iteratorsNext: lazyIteratorsNextFactory())
    }
}

// MARK: LazyConcatenateIterator

public struct LazyConcatenateIterator<Element>: IteratorProtocol {
    
    typealias IteratorNext = () -> Element?
    
    let iteratorsNext: [IteratorNext]
    var iteratorIndex: Int = 0
    
    public mutating func next() -> Element? {
        guard let iteratorNextExecute = iteratorsNext[safe: iteratorIndex] else {
            return nil
        }
        guard let iteratorNext = iteratorNextExecute() else {
            iteratorIndex += 1
            return next()
        }
        return iteratorNext
    }
}

// MARK: LazySequenceProtocol + LazyConcatenateSequence

extension LazySequenceProtocol {
    
    /// Concantenate this lazy sequence with other sequence with same type of element
    /// - Parameter sequence: Sequence to be concantenated
    /// - Returns: LazyConcatenateSequence of the same element
    public func concantenate<S: Sequence>(with sequence: S) -> LazyConcatenateSequence<Element> where S.Element == Element {
        LazyConcatenateSequence(self, sequence)
    }
    
    /// Concantenate this lazy sequence with other sequences with same type of this sequence
    /// - Parameter sequences: Sequences to be concantenated
    /// - Returns: LazyConcatenateSequence of the same element
    public func concantenate(with sequences: Self...) -> LazyConcatenateSequence<Element> {
        LazyConcatenateSequence(
            sequences: sequences.inserted(with: self, at: .zero)
        )
    }
}
