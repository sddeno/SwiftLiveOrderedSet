//
//  File.swift
//  SwiftLiveOrderedSet
//
//  Created by Shubham Deshmukh on 03/07/25.
//

import Foundation

final class AVLTreeNode<Element: Comparable> {
    var value: Element
    var left: AVLTreeNode?
    var right: AVLTreeNode?
    var height: Int

    init(_ value: Element) {
        self.value = value
        self.height = 1
    }
}
