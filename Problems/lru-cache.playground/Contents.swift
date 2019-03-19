import UIKit

// https://leetcode.com/problems/lru-cache/


// We need O(1) get / set
// Hash can do that but also need order
// We need a Double ended LL to keep the order

class Entry {
    var value: Int = -1
    var key: Int = -1
    var next: Entry?
    var prev: Entry?
}

class LRUCache {
    // LL data
    typealias Node = Entry
    var start: Node?
    var end: Node?
    
    var data: [Int: Node] = [:]
    var capacity: Int = 0
    var lastKey: Int = 0
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        guard let v = data[key] else {
            return -1
        }
        // Remove it from current position
        removeNode(v)
        // Place it on the top as it's got hit
        addAtTop(v)
        
        return v.value
    }
    
    func put(_ key: Int, _ value: Int) {
        // If key exist
        //  1. Remove it fro current position
        //  2. Update the value
        //  3. Place it on the top
        // If key doesn't exist
        //  1. Add it on the top
        //  2. If size > capacity then remove last one
        if let node = data[key] {
            node.value = value
            removeNode(node)
            addAtTop(node)
        } else {
            let node = Node()
            node.key    = key
            node.value  = value
            if data.count >= capacity, let end = end {
                data.removeValue(forKey: end.key)
                removeNode(end)
                addAtTop(node)
            } else {
                addAtTop(node)
            }
            data[key] = node
        }
    }
    
    private func addAtTop(_ node: Node) {
        node.prev = nil
        node.next = start
        start?.prev = node
        start = node
        if end == nil {
            end = start
        }
    }
    
    private func removeNode(_ node: Node) {
        let prev = node.prev
        let next = node.next
        
        prev?.next = next
        next?.prev = prev
        
        if prev == nil {
            start = next
        }
        
        if next == nil {
            end = prev
        }
    }
}

let lru = LRUCache(2)
lru.put(1, 1)
lru.put(2, 2)
lru.get(1)
lru.put(3, 3)
lru.get(2)
lru.put(4, 4)
lru.get(1)
lru.get(3)
lru.get(4)
