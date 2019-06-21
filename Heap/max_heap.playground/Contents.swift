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
    var i: Int8 = 0
    
    private var data: [Int] = []
    private(set) var size: Int = 0
    
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
    
    /**
     * Allows you to change an element. This reorders the heap so that
     * the max-heap property still holds.
     * Time: O(lg n)
     */
    func replace(at index: Int, key: Int) {
        assert(key > data[index], "“new key is smaller than current key")
        var i = index
        data[i] = key
        while i > 0 && data[parent(of: i)] < data[i] {
            data.swapAt(i, parent(of: i))
            i = parent(of: i)
        }
    }
    
    
    func insert(_ key: Int) {
        data.append(Int.min)
        size += 1
        replace(at: size - 1, key: key)
    }
}


let heap = Heap()
let array = [4, 1, 6, 7, 9, 100, 2]
heap.buildMaxHeap(from: array)
heap.insert(200)
let data = heap.sort()
print(data)



// Examples of algorithms that can benefit from a priority queue:
//  Event-driven simulations. Each event is given a timestamp and you want events to be performed in order of their timestamps. The priority queue makes it easy to find the next event that needs to be simulated.
//  Dijkstra's algorithm for graph searching uses a priority queue to calculate the minimum cost.
//  Huffman coding for data compression. This algorithm builds up a compression tree. It repeatedly needs to find the two nodes with the smallest frequencies that do not have a parent node yet.
//  A* pathfinding for artificial intelligence.
//  Lots of other places!

// There are different ways to implement priority queues:
// As a sorted array. The most important item is at the end of the array. Downside: inserting new items is slow because they must be inserted in sorted order.
// As a balanced binary search tree. This is great for making a double-ended priority queue because it implements both "find minimum" and "find maximum" efficiently.
// As a heap. The heap is a natural data structure for a priority queue. In fact, the two terms are often used as synonyms. A heap is more efficient than a sorted array because a heap only has to be partially sorted. All heap operations are O(log n).

class PriorityQueue {
    
}

