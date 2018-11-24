import Foundation

class LinkedListNode<T> {
    let value: T
    
    var next: LinkedListNode?
    weak var prev: LinkedListNode?
    
    required init(value: T) {
        self.value = value
    }
}

class LinkedList<T> where T: Comparable {
    typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var tail: Node?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node? {
        return head
    }
    
    var last: Node? {
        return tail
    }
    
    func insertFirst(value: T) {
        let node = LinkedListNode(value: value)
        
        guard let head = head else {
            self.head = node
            self.tail = node
            return
        }
        
        node.next = head
        head.prev = node
        self.head = node
    }
    
    func insertLast(value: T) {
        let node = LinkedListNode(value: value)
        
        node.prev  = tail
        tail?.next = node
        self.tail  = node
        
        if head == nil { head = tail }
    }
    
    func node(atIndex index: Int) -> Node? {
        var count = 0
        var current = head
        while let next = current?.next {
            if count == index { return current }
            count += 1
            current = next
        }
        return tail
    }
    
    public subscript(index: Int) -> T? {
        let node = self.node(atIndex: index)
        return node?.value
    }
    
    func insert(at index: Int, value: T) {
        if index < 0 { return }
        let node = LinkedListNode(value: value)

        if index == 0 {
            // {NODE}--->[HEAD]---[NEXT]
            node.next = head
            head?.prev = node
            self.head = node
        } else {
            // --->[PREV] ----->{NODE}----->[NEXT]
            
            let prev = self.node(atIndex: index - 1)
            let next = prev?.next
            
            node.next = next
            next?.prev = node
            
            node.prev = prev
            prev?.next = node
        }
    }
    
    // {HEAD} -->[NEXT]
    func deleteFirst() -> T? {
        let value = head?.value
        let next = head?.next
        next?.prev = nil
        head?.next = nil

        self.head = next
        return value
    }
    
    // ---->[PREV]---{TAIL}
    func deleteLast() -> T? {
        let value = tail?.value
        let prev = tail?.prev
        
        tail?.prev = nil
        prev?.next = nil
        
        self.tail = prev
        return value
    }
    
    // case 1: {HEAD at index}--->[NEXT]
    // case 2: --->[PREV]--->{node at Index}--->[NEXT]--
    // case 3: --->[PREV]--->{tail at index}
    func delete(at index: Int) -> T? {
        // Case 1
        if index == 0 {
            return deleteFirst()
        }
        let node = self.node(atIndex: index)
        let value = node?.value
        let prev = node?.prev
        // Case 3:
        if node === tail {
            prev?.next = nil
            tail?.prev = nil
            self.tail = prev
            return value
        }
        // Case 2:
        let next = node?.next
        
        prev?.next = next
        next?.prev = prev
        
        node?.next = nil
        node?.prev = nil
        
        return value
    }
    
    // Input:   [A]--->[B]--->[C]--->[D]
    // Output:  [D]--->[C]--->[B]--->[A]
    func reverse() {
        var node = head
        tail = node
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.prev)
            head = currentNode
        }
    }
    
    // Source: [HEAD]-->[A]-->[D]-->[C]
    // Other: [HEAD]-->[C]-->[A]-->[E]
    // SourceOutput: [HEAD]-->[A]-->[A]-->[C]-->[C]-->[D]-->[E]
    func sortedMerge(_ other: LinkedList?) {
        self.head = LinkedList.sortedMerge(self.head, b: other?.head)
        var current = head
        while let next = head?.next {
            current = next
        }
        self.tail = current
    }
    
    func printList() {
        var string = ""
        var current = head
        while let next = current?.next {
            string += "\(String(describing: current?.value)), "
            current = next
        }
        string += "\(String(describing: current?.value))"
        print(string)
    }
    
    func printListReverse() {
        var current = tail
        var string = ""

        while let prev = current?.prev {
            string += "\(String(describing: current?.value)), "
            current = prev
        }
        string += "\(String(describing: current?.value))"
        print(string)
    }
    
    static func sort(_ node: inout LinkedListNode<T>?) {
        if node == nil || node?.next == nil { return }
        var a: LinkedListNode<T>?
        var b: LinkedListNode<T>?
        split(node, left: &a, right: &b)
        sort(&a)
        sort(&b)
        node = sortedMerge(a, b: b)
    }
    
    static func split(_ node: LinkedListNode<T>?, left: inout LinkedListNode<T>?, right: inout LinkedListNode<T>? ) {
        var slow = node
        var fast = node?.next
        
        while let next = fast?.next?.next {
            slow = slow?.next
            fast = next
        }
        left = node
        right = slow?.next
        slow?.next = nil
    }
    
    static func sortedMerge(_ a: LinkedListNode<T>?, b: LinkedListNode<T>?) -> LinkedListNode<T>? {
        if a == nil { return b }
        if b == nil { return a }
        
        var result  = a
        if let valueOfA = a?.value, let valueOfB = b?.value {
            if valueOfA <= valueOfB {
                result  = a
                result?.next = sortedMerge(a?.next, b: b)
                result?.next?.prev = a
            } else {
                result = b
                result?.next = sortedMerge(a, b: b?.next)
                result?.next?.prev = b
            }
        }
        return result
    }
    
    static func printList(of head: LinkedListNode<T>? ) {
        var string = ""
        var current = head
        while let next = current?.next {
            string += "\(String(describing: current?.value)), "
            current = next
        }
        string += "\(String(describing: current?.value))"
        print(string)
    }
}


let list1 = LinkedList<Int>()
list1.insertLast(value: 5)
list1.insertLast(value: 10)
list1.insertLast(value: 15)

var list2 = LinkedList<Int>()
list2.insertLast(value: 20)
list2.insertLast(value: 3)
list2.insertLast(value: 2)

var merged = LinkedList.sortedMerge(list1.first, b: list2.first)
LinkedList<Int>.printList(of: merged)

var head = list2.first
LinkedList<Int>.sort(&head)
LinkedList<Int>.printList(of: head)
