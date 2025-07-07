//
//  File.swift
//  SwiftLiveOrderedSet
//
//  Created by Shubham Deshmukh on 07/07/25.
//

import Foundation

final class TreeBox<Element: Comparable> {
    var tree: AVLTree<Element>

    init(tree: AVLTree<Element>) {
        self.tree = tree
    }

    func copy() -> TreeBox<Element> {
        return TreeBox(tree: tree.copy())
    }
}
