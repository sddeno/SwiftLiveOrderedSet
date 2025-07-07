# SwiftLiveOrderedSet

A pure Swift package providing a `SwiftLiveOrderedSet<Element: Comparable>` — a set that keeps elements in live sorted order using an AVL tree. 

## Features
✅ Unique elements  
✅ Always sorted (like C++ `std::set`)  
✅ O(log n) insert, remove, contains  
✅ Fast in-order iteration
### ✅ Copy-on-Write (COW) Support
`SwiftLiveOrderedSet` now implements copy-on-write semantics. This means:
- Multiple set copies share storage efficiently until one is mutated.
- You get true Swift-style value type behavior.

[![COW Supported](https://img.shields.io/badge/COW-Supported-brightgreen)](https://github.com/your-repo-link)

[![Swift Package Index](https://swiftpackageindex.com/sddeno/SwiftLiveOrderedSet/badge.svg)](https://swiftpackageindex.com/sddeno/SwiftLiveOrderedSet)


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
