import XCTest
@testable import SwiftLiveOrderedSet

final class SwiftLiveOrderedSetTests: XCTestCase {

    func testInsertion() {
        var set = SwiftLiveOrderedSet<Int>()
        set.insert(10)
        set.insert(5)
        set.insert(15)
        set.insert(10)  // Duplicate insert

        var result: [Int] = []
        for val in set {
            result.append(val)
        }

        XCTAssertEqual(result, [5, 10, 15], "Elements should be sorted and unique")
        XCTAssertTrue(set.contains(10))
        XCTAssertTrue(set.contains(5))
        XCTAssertFalse(set.contains(20))
    }

    func testRemoval() {
        var set = SwiftLiveOrderedSet<Int>()
        set.insert(10)
        set.insert(5)
        set.insert(15)

        set.remove(10)
        XCTAssertFalse(set.contains(10))

        var result: [Int] = []
        for val in set {
            result.append(val)
        }

        XCTAssertEqual(result, [5, 15], "10 should be removed and elements sorted")
    }

    func testEmptySet() {
        let set = SwiftLiveOrderedSet<Int>()
        XCTAssertFalse(set.contains(1))
        XCTAssertTrue(Array(set).isEmpty)
    }

    func testOrderAfterOperations() {
        var set = SwiftLiveOrderedSet<Int>()
        set.insert(50)
        set.insert(20)
        set.insert(70)
        set.insert(10)
        set.insert(30)

        set.remove(20)

        let sorted = Array(set)
        XCTAssertEqual(sorted, [10, 30, 50, 70], "Set should maintain live sorted order after removal")
    }
}
