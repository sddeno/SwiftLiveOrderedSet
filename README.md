# SwiftLiveOrderedSet

A pure Swift package providing a `SwiftLiveOrderedSet<Element: Comparable>` — a set that keeps elements in live sorted order using an AVL tree. 

## Features
✅ Unique elements  
✅ Always sorted (like C++ `std::set`)  
✅ O(log n) insert, remove, contains  
✅ Fast in-order iteration  

## Usage

```swift
import SwiftLiveOrderedSet

var set = SwiftLiveOrderedSet<Int>()
set.insert(10)
set.insert(5)
set.insert(20)

print(Array(set))  // [5, 10, 20]

set.remove(10)
print(Array(set))  // [5, 20]
