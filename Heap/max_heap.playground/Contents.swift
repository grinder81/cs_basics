import Foundation

// Fact 1:
// In a max-heap:
//    parent nodes have a greater value than each of their children.
// In a min-heap:
//    every parent node has a smaller value than its child nodes.
// This is called the "heap property", and it is true for every single node in the tree.

// FACT 2:
// Searching isn't a top priority in a heap since the purpose of a heap
// is to put the largest (or smallest) node at the front and to allow relatively fast inserts and deletes.
class Heap {
    private var data: [Int]
    private(set) var size: Int = 0
    
    init(capacity: Int) {
        data = Array(repeating: 0, count: capacity)
    }
    
    func parent(of i: Int) -> Int {
        return (i - 1) / 2
    }
    
    func left(childOf i: Int) -> Int {
        return 2 * i + 1
    }
    
    func right(childOf i: Int) -> Int {
        return 2 * i + 2
    }
    
    // That should be max value for max-heap
    // or min value for min-heap.
    // Heap work ONLY for this property
    var peak: Int? {
        return data.first
    }
}

extension Heap {
    // The MAX-HEAPIFY procedure, which runs in O(lg n) time,
    // is the key to maintaining the max-heap property.
    // A recursive method to heapify a subtree with the root at given index
    // This method assumes that the subtrees are already heapified
    // If A[i] < A[Left] or A[i] < A[Right] which mean we need to keep
    // heapify until all the subtree underneeth i need to saisfy the
    // Max-Heap property
    func maxHeapify(_ i: Int) {
        let l = left(childOf: i)
        let r = right(childOf: i)
        
        var largestOne = i
        
        if l < size && data[l] > data[largestOne] {
            largestOne = l
        }
        
        if r < size && data[r] > data[largestOne] {
            largestOne = r
        }
        
        if largestOne != i {
            data.swapAt(i, largestOne)
            maxHeapify(largestOne)
        }
    }
    
    // A[n/2....n-1] are all leaves of the tree
    // Time: Every maxHeapify is O(lg n) and n/2 elements so it should be
    // O(n lg n) but it's possible to proof by Floyd's algorithm that it's
    // actually O(lg n). That's bit complex math!
    // O(n) = n/2 * 1 + n/4 * 2 + n/8 * 3 ....
    // That's become O(n)
    func buildMaxHeap(from array: [Int]) {
        data = array
        size = array.count
        for index in stride(from: (array.count/2 - 1), through: 0, by: -1) {
            maxHeapify(index)
        }
    }
    
    // That's O(n lg n)
    // In place sort
    // NOT stable: the relative order of identical elements is not preserved.
    func sort() -> [Int] {
        for index in stride(from: data.count - 1, through: 1, by: -1) {
            data.swapAt(0, index)
            size -= 1
            maxHeapify(0)
        }
        return data
    }
    
    func sortArray(from array: [Int]) -> [Int] {
        buildMaxHeap(from: array)
        return sort()
    }
}

let heap = Heap(capacity: 10)
let array = [4, 1, 6, 7, 9, 100, 2]
heap.buildMaxHeap(from: array)
let data = heap.sort()
print(data)

