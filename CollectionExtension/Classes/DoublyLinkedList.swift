//
//  DoublyLinkedList.swift
//  CollectionExtension
//
//  Created by Nayanda Haberty on 22/8/23.
//

import Foundation

// MARK: DoublyLinkedList

/// Use this instead of regular array if you need to do many mutable manipulation.
/// This generally will have less time complexity for most of manipulation task
/// Use array instead if you need to do many direct access to the element using index
/// This generally will have more time complexity for most of accessing task
final public class DoublyLinkedList<Element> {
    var root: Node?
    var tail: Node?
    private var populated: Set<Node> = .init()
    
    /// First element in this DoublyLinkedList
    @inlinable public var first: Element? { firstNode?.element }
    
    /// Last element in this DoublyLinkedList
    @inlinable public var last: Element? { lastNode?.element }
    
    /// First node in this DoublyLinkedList
    public var firstNode: Node? { root }
    
    /// Last node in this DoublyLinkedList
    public var lastNode: Node? { tail }
    
    /// Number of element in this DoublyLinkedList
    public var count: Int { populated.count }
    
    public init() { }
    
    public convenience init<S>(_ sequence: S) where S: Sequence, Element == S.Element {
        self.init()
        append(contentsOf: sequence)
    }
    
    /// Get Node at a given index
    /// - Complexity: O (*n*) or O (*m*) which one is less, where *n* is the given index - 1 and *m* is count - index - 1
    /// - Parameter index: Index of Node
    /// - Returns: Node at a given index. `nil` if the index is out of bounds
    public func node(at index: Int) -> Node? {
        if index < 0 || index > count { return nil }
        let reverseIndex = count - index - 1
        if index < reverseIndex {
            return root?.nextNode(for: index)
        } else {
            return tail?.previousNode(for: reverseIndex)
        }
    }
    
    /// Check whether this sequence have a given node or not.
    /// This will use the Node object identifier to search, so it will ignore the element inside the node.
    /// - Complexity: O (1) on average
    /// - Parameter node: Node to search
    /// - Returns: `True` if the node is found and `False` if not
    public func contains(node: Node) -> Bool {
        populated.contains(node)
    }
    
    /// Append a node to this DoublyLinkedList
    /// It will search for the existing Node and move it to the last if found
    /// - Complexity: O (1) on average
    /// - Parameter node: node appended at the last of this sequence
    public func append(node: Node) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        naiveAppend(node: node)
    }
    
    /// Append a new element to this sequence
    /// - Complexity: O (1)
    /// - Parameter newElement: New element that will be added at the last of this sequence
    public func append(_ newElement: Element) {
        naiveAppend(node: Node(element: newElement))
    }
    
    /// Append a new elements to this sequence
    /// - Complexity: O (*n*) where *n* is the length of new elements
    /// - Parameter newElements: New elements that will be added at the last of this sequence
    public func append<S>(contentsOf newElements: S) where S: Sequence, Element == S.Element {
        prepareNodes(for: newElements) { sequenceRoot, sequenceTail in
            guard root != nil, let tail = self.tail else {
                root = sequenceRoot
                tail = sequenceTail
                return
            }
            tail.next = sequenceRoot
            sequenceRoot.previous = tail
            self.tail = sequenceTail
        }
    }
    
    /// Inset a node to this DoublyLinkedList
    /// It will search for the existing Node and move it to the given index if found
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (1) on average
    /// - Parameters:
    ///   - node: Node inserted
    ///   - index: Index of node
    public func insert(node: Node, at index: Int) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        if index == count {
            naiveAppend(node: node)
            return
        }
        guard index >= 0 && index < count else {
            fatalError("Index should be greater than zero and less than sequence count")
        }
        let nodeAtIndex = self.node(at: index)
        nodeAtIndex?.previous?.next = node
        node.previous = nodeAtIndex?.previous
        nodeAtIndex?.previous = node
        node.next = nodeAtIndex
        populated.insert(node)
    }
    
    /// Inset a new element to this DoublyLinkedList
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (1) on average
    /// - Parameters:
    ///   - newElement: New element inserted
    ///   - index: Index of the new element
    public func insert(_ newElement: Element, at index: Int) {
        insert(node: Node(element: newElement), at: index)
    }
    
    /// Inset a new elements to this DoublyLinkedList
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (*n*) where *n* is the length of new elements
    /// - Parameters:
    ///   - newElements: New elements inserted
    ///   - index: Index of the new elements
    public func insert<S>(contentsOf newElements: S, at index: Int) where S: Sequence, Element == S.Element {
        if index == count {
            append(contentsOf: newElements)
            return
        }
        guard index >= 0 && index < count else {
            fatalError("Index should be greater than zero and less than sequence count")
        }
        prepareNodes(for: newElements) { sequenceRoot, sequenceTail in
            let nodeAtIndex = self.node(at: index)
            nodeAtIndex?.previous?.next = sequenceRoot
            sequenceRoot.previous = nodeAtIndex?.previous
            nodeAtIndex?.previous = sequenceTail
            sequenceTail.next = nodeAtIndex
        }
    }
    
    @discardableResult
    /// Remove a node from this sequence
    /// - Complexity: O (1) on average
    /// - Parameter node: Node to be removed
    /// - Returns: `True` if Node is exist in this sequence and removed, otherwise it will return `False`
    public func remove(node: Node) -> Bool {
        guard contains(node: node) else {
            return false
        }
        naiveRemove(node: node)
        return true
    }
    
    @discardableResult
    /// Remove element at a given position
    /// - Complexity: O (*n*) or O (*m*) which one is less, where *n* is the given position - 1 and *m* is count - position - 1
    /// - Parameter position: Position of the element
    /// - Returns: Element removed, it will be nil if the position is out of bounds
    public func remove(at position: Int) -> Element? {
        guard let node = self.node(at: position) else {
            return nil
        }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// Remove first element from this sequence
    /// - Complexity: O (1) on average
    /// - Returns: Element removed, it will be nil if the sequence is empty
    public func removeFirst() -> Element? {
        guard let node = firstNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// Remove last element from this sequence
    /// - Complexity: O (1) on average
    /// - Returns: Element removed, it will be nil if the sequence is empty
    public func removeLast() -> Element? {
        guard let node = lastNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    /// Remove all element that matched by the given closure
    /// - Complexity: O(*n*), where *n* is the length of this sequence
    /// - Parameter shouldBeRemoved: Array that accept the element and return Bool indicating the element should be removed or not
    public func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
        guard let currentRoot = root else { return }
        var current: Node? = currentRoot
        var last: Node? = current
        repeat {
            let next = current?.next
            defer { current = next }
            guard let node = current, try shouldBeRemoved(node.element) else {
                last = current
                continue
            }
            if self.root === node {
                let newRoot = node.next
                newRoot?.previous = nil
                self.root = newRoot
            }
            node.removeFromLink()
            populated.remove(node)
        } while current != nil
        self.tail = last
    }
    
    /// Remove all elements from this sequence
    /// - Complexity: O (1)
    public func removeAll() {
        root = nil
        tail = nil
        populated = .init()
    }
}

// MARK: DoublyLinkedList Internal

extension DoublyLinkedList {
    
    private func naiveAppend(node: Node) {
        defer { populated.insert(node) }
        if self.root == nil {
            root = node
            tail = node
            return
        }
        node.previous = tail
        tail?.next = node
        tail = node.mostNext
    }
    
    private func naiveRemove(node: Node) {
        defer { populated.remove(node) }
        if root === node {
            let newRoot = node.next
            newRoot?.previous = nil
            root = newRoot
        }
        if tail === node {
            let newTail = node.previous
            newTail?.next = nil
            tail = newTail
        }
        node.removeFromLink()
    }
    
    private func prepareNodes<S>(
        for sequence: S,
        then doTask: (_ sequenceRoot: Node, _ sequenceTail: Node) -> Void)
    where S: Sequence, Element == S.Element {
        let nodes: (root: Node, tail: Node)? = sequence.reduce(nil) { partialResult, element in
            let node = Node(element: element)
            populated.insert(node)
            guard let nodes = partialResult else { return (node, node) }
            nodes.tail.next = node
            node.previous = nodes.tail
            return (nodes.root, node)
        }
        guard let nodes = nodes else { return }
        doTask(nodes.root, nodes.tail)
    }
}

// MARK: DoublyLinkedList Node

extension DoublyLinkedList {
    /// Node of DoubleLinkedList
    public class Node {
        /// Element stored in this Node
        public var element: Element
        public internal(set) var previous: Node?
        public internal(set) var next: Node?
        
        init(element: Element,
             previous: Node? = nil,
             next: Node? = nil) {
            self.element = element
            self.previous = previous
            self.next = next
        }
    }
}

// MARK: DoublyLinkedList Node Internal

extension DoublyLinkedList.Node {
    
    func removeFromLink() {
        previous?.next = next
        next?.previous = previous
        next = nil
        previous = nil
    }
    
    var mostNext: DoublyLinkedList<Element>.Node {
        next?.mostNext ?? self
    }
    
    var mostPrevious: DoublyLinkedList<Element>.Node {
        previous?.mostPrevious ?? self
    }
    
    func nextNode(for count: Int) -> DoublyLinkedList<Element>.Node? {
        guard count != 0 else { return self }
        return next?.nextNode(for: count - 1)
    }
    
    func previousNode(for count: Int) -> DoublyLinkedList<Element>.Node? {
        guard count != 0 else { return self }
        return previous?.previousNode(for: count - 1)
    }
}

// MARK: DoublyLinkedList Node + Hashable

extension DoublyLinkedList.Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    public static func == (lhs: DoublyLinkedList<Element>.Node, rhs: DoublyLinkedList<Element>.Node) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

// MARK: DoublyLinkedListIterator

public struct DoublyLinkedListIterator<Element>: IteratorProtocol {
    
    private var currentNode: Node?
    
    init(root: DoublyLinkedList<Element>.Node?) {
        self.currentNode = root?.toIteratorNode()
    }
    
    public mutating func next() -> Element? {
        defer { currentNode = currentNode?.next }
        return currentNode?.element
    }
}

// MARK: DoublyLinkedListIterator.Node

extension DoublyLinkedListIterator {
    class Node {
        let element: Element
        let next: Node?
        
        init(element: Element, next: Node?) {
            self.element = element
            self.next = next
        }
    }
}

// MARK: DoublyLinkedList.Node + Extensions

extension DoublyLinkedList.Node {
    func toIteratorNode() -> DoublyLinkedListIterator<Element>.Node {
        .init(element: element, next: next?.toIteratorNode())
    }
}

// MARK: DoublyLinkedList + Sequence

extension DoublyLinkedList: Sequence {
    public typealias Iterator = DoublyLinkedListIterator<Element>
    
    public func makeIterator() -> DoublyLinkedListIterator<Element> {
        DoublyLinkedListIterator(root: root)
    }
}

// MARK: DoublyLinkedList + Collection

extension DoublyLinkedList: Collection {
    
    public typealias Index = Int
    
    public subscript(position: Int) -> Element {
        get {
            node(at: position)!.element
        }
        set {
            node(at: position)!.element = newValue
        }
    }
    
    @inlinable public func index(after index: Int) -> Int {
        index + 1
    }
    
    @inlinable public var startIndex: Int { 0 }
    
    public var endIndex: Int { count }
}

// MARK: DoublyLinkedList + ExpressibleByArrayLiteral

extension DoublyLinkedList: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element
    
    @inlinable public convenience init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
