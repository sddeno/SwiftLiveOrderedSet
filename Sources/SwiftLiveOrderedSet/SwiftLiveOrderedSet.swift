// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct SwiftLiveOrderedSet<Element: Comparable>: Sequence {
    private var box: TreeBox<Element>

    public init() {
        box = TreeBox(tree: AVLTree())
    }

    private mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }

    public mutating func insert(_ value: Element) {
        ensureUnique()
        box.tree.insert(value)
    }

    public mutating func remove(_ value: Element) {
        ensureUnique()
        box.tree.remove(value)
    }

    public func contains(_ value: Element) -> Bool {
        return box.tree.contains(value)
    }

    public func makeIterator() -> AnyIterator<Element> {
        var elements: [Element] = []
        box.tree.inOrderTraversal { elements.append($0) }
        var index = 0
        return AnyIterator {
            guard index < elements.count else { return nil }
            defer { index += 1 }
            return elements[index]
        }
    }
}
