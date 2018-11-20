import Foundation

class LinkedListNode<T> {
    let value: T
    
    var next: LinkedListNode?
    weak var prev: LinkedListNode?
    
    required init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
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
            string += "\(current?.value), "
            current = prev
        }
        string += "\(current?.value)"
        print(string)
    }

}


let list = LinkedList<Int>()
list.first
list.isEmpty
list.insertFirst(value: 10)
list.insertFirst(value: 9)
list.insertLast(value: 11)
list.first?.value
list.last?.value
list[0]
list.printList()
list.insert(at: 0, value: 100)
list.printList()
list.printListReverse()
list.deleteFirst()
list.printList()
list.printListReverse()
list.deleteLast()
list.printList()
list.printListReverse()
list.delete(at: 0)
list.printList()
list.printListReverse()
