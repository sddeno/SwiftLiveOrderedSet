//
//  File.swift
//  SwiftLiveOrderedSet
//
//  Created by Shubham Deshmukh on 03/07/25.
//

import Foundation

final class AVLTree<Element: Comparable> {
    private var root: AVLTreeNode<Element>?

    var count: Int = 0

    func insert(_ value: Element) {
        root = insert(root, value)
    }

    func remove(_ value: Element) {
        root = remove(root, value)
    }

    func contains(_ value: Element) -> Bool {
        return contains(root, value)
    }

    func inOrderTraversal(_ visit: (Element) -> Void) {
        inOrder(root, visit)
    }

    // Internal insert
    private func insert(_ node: AVLTreeNode<Element>?, _ value: Element) -> AVLTreeNode<Element>? {
        guard let node = node else {
            count += 1
            return AVLTreeNode(value)
        }

        if value < node.value {
            node.left = insert(node.left, value)
        } else if value > node.value {
            node.right = insert(node.right, value)
        } else {
            // No duplicates allowed in set
            return node
        }

        updateHeight(node)

        let balance = balanceFactor(node)

        // Left Left
        if balance > 1 && value < node.left!.value {
            return rotateRight(node)
        }

        // Right Right
        if balance < -1 && value > node.right!.value {
            return rotateLeft(node)
        }

        // Left Right
        if balance > 1 && value > node.left!.value {
            node.left = rotateLeft(node.left!)
            return rotateRight(node)
        }

        // Right Left
        if balance < -1 && value < node.right!.value {
            node.right = rotateRight(node.right!)
            return rotateLeft(node)
        }

        return node
    }


    // Internal remove
    private func remove(_ node: AVLTreeNode<Element>?, _ value: Element) -> AVLTreeNode<Element>? {
        guard let node = node else { return nil }

        if value < node.value {
            node.left = remove(node.left, value)
        } else if value > node.value {
            node.right = remove(node.right, value)
        } else {
            // Node with only one child or no child
            if node.left == nil || node.right == nil {
                let temp = node.left ?? node.right
                if temp == nil {
                    // No child
                    count -= 1
                    return nil
                } else {
                    // One child
                    count -= 1
                    return temp
                }
            } else {
                // Node with two children
                let temp = minValueNode(node.right!)
                node.value = temp.value
                node.right = remove(node.right, temp.value)
            }
        }

        updateHeight(node)
        let balance = balanceFactor(node)

        // Left Left
        if balance > 1 && balanceFactor(node.left) >= 0 {
            return rotateRight(node)
        }

        // Left Right
        if balance > 1 && balanceFactor(node.left) < 0 {
            node.left = rotateLeft(node.left!)
            return rotateRight(node)
        }

        // Right Right
        if balance < -1 && balanceFactor(node.right) <= 0 {
            return rotateLeft(node)
        }

        // Right Left
        if balance < -1 && balanceFactor(node.right) > 0 {
            node.right = rotateRight(node.right!)
            return rotateLeft(node)
        }

        return node
    }

    // When removing, we may need to find the in-order successor
    private func minValueNode(_ node: AVLTreeNode<Element>) -> AVLTreeNode<Element> {
        var current = node
        while let left = current.left {
            current = left
        }
        return current
    }


    private func contains(_ node: AVLTreeNode<Element>?, _ value: Element) -> Bool {
        guard let node = node else { return false }
        if value == node.value {
            return true
        } else if value < node.value {
            return contains(node.left, value)
        } else {
            return contains(node.right, value)
        }
    }

    private func inOrder(_ node: AVLTreeNode<Element>?, _ visit: (Element) -> Void) {
        guard let node = node else { return }
        inOrder(node.left, visit)
        visit(node.value)
        inOrder(node.right, visit)
    }

    // TODO: Add rotations + height updates + balance factor
    
    private func height(_ node: AVLTreeNode<Element>?) -> Int {
        return node?.height ?? 0
    }

    private func updateHeight(_ node: AVLTreeNode<Element>) {
        node.height = 1 + max(height(node.left), height(node.right))
    }

    private func balanceFactor(_ node: AVLTreeNode<Element>?) -> Int {
        return (node == nil) ? 0 : height(node!.left) - height(node!.right)
    }

    private func rotateRight(_ y: AVLTreeNode<Element>) -> AVLTreeNode<Element> {
        let x = y.left!
        let T2 = x.right

        // Perform rotation
        x.right = y
        y.left = T2

        // Update heights
        updateHeight(y)
        updateHeight(x)

        return x
    }

    private func rotateLeft(_ x: AVLTreeNode<Element>) -> AVLTreeNode<Element> {
        let y = x.right!
        let T2 = y.left

        // Perform rotation
        y.left = x
        x.right = T2

        // Update heights
        updateHeight(x)
        updateHeight(y)

        return y
    }

    func copy() -> AVLTree<Element> {
        let newTree = AVLTree<Element>()
        self.inOrderTraversal { newTree.insert($0) }
        return newTree
    }
}
