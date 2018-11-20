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
