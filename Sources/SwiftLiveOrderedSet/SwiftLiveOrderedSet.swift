// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct SwiftLiveOrderedSet<Element: Comparable>: Sequence {
    private var tree = AVLTree<Element>()

    public init() {}

    public mutating func insert(_ value: Element) {
        tree.insert(value)
    }

    public mutating func remove(_ value: Element) {
        tree.remove(value)
    }

    public func contains(_ value: Element) -> Bool {
        return tree.contains(value)
    }

    public func makeIterator() -> AnyIterator<Element> {
        var elements: [Element] = []
        tree.inOrderTraversal { elements.append($0) }
        var index = 0
        return AnyIterator {
            guard index < elements.count else { return nil }
            defer { index += 1 }
            return elements[index]
        }
    }
}
