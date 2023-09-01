//
//  Sequence+TypeErase.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 1/9/23.
//

import Foundation

extension Sequence {
    public func eraseToAnySequence() -> AnySequence<Element> {
        AnySequence(self)
    }
}

extension LazySequenceProtocol {
    public func eraseToAnyLazySequence() -> AnyLazySequence<Element> {
        AnyLazySequence {
            var iterator = self.makeIterator()
            return { iterator.next() }
        }
    }
}

// MARK: AnyLazySequence

public struct AnyLazySequence<Element>: LazySequenceProtocol {
    public typealias Iterator = AnyLazyIterator<Element>
    typealias IteratorNextCaller = Iterator.IteratorNextCaller
    
    let iteratorNextCallerFactory: () -> IteratorNextCaller
    
    public func makeIterator() -> AnyLazyIterator<Element> {
        AnyLazyIterator(iteratorNextCaller: iteratorNextCallerFactory())
    }
    
}

// MARK: AnyLazyIterator

public struct AnyLazyIterator<Element>: IteratorProtocol {
    typealias IteratorNextCaller = () -> Element?
    
    let iteratorNextCaller: IteratorNextCaller
    
    public func next() -> Element? {
        iteratorNextCaller()
    }
}
