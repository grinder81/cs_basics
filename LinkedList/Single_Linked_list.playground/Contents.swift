import UIKit

class LinkedListNode {
    var value: Int
    var next: LinkedListNode?
    init(value: Int) {
        self.value = value
    }
}

class SingleLinkedList {
    typealias Node = LinkedListNode
    
    var head: Node?
    
    func insert(first value: Int) {
        let node = Node(value: value)
        if head == nil {
            head = node
            return
        }
        node.next = head
        head = node
    }
    
    func insert(after node: Node, value: Int) {
        let newNode = Node(value: value)
        newNode.next = node.next
        node.next = newNode
    }
    
    func insert(end value: Int) {
        let node = Node(value: value)
        if head == nil {
            head = node
            return
        }

        var current = head
        while let next = current?.next {
            current = next
        }
        current?.next = node
    }
    
    static func printList(_ node: Node?) {
        var current = node
        while let next = current?.next {
            print(current?.value)
            current = next
        }
        print(current?.value)
    }
    
    static func reverseIterative(_ node: Node?) -> Node? {
        var dummy: Node?
        var pre: Node?

        dummy = Node(value: 0)
        dummy?.next = node
        pre = dummy
        
        var current = pre?.next
        
        while let next = current?.next {
            current?.next = next.next
            next.next = pre?.next
            pre?.next = next
        }
        return dummy?.next
    }
    
    static func reverseRecursion(_ node: Node?) -> Node? {
        if node == nil || node?.next == nil {
            return node
        }
        let revNode = reverseRecursion(node?.next)
        node?.next?.next = node
        node?.next = nil
        return revNode
    }
    
    static func addTwoNumbers(_ a: Node?, _ b: Node?) -> Node? {
        let rA = reverseIterative(a)
        let rB = reverseIterative(b)
        return reverseIterative(additionHelper(rA, rB, nil))
    }
    
    static func additionHelper(_ a: Node?, _ b: Node?, _ carry: Int? ) -> Node? {
        if a != nil || b != nil || carry != nil {
            var value = 0
            value += a?.value ?? 0
            value += b?.value ?? 0
            value += carry ?? 0
            
            let newCarry = value / 10 > 0 ? value / 10 : nil
            let node = Node(value: value % 10)
            node.next = additionHelper(a?.next, b?.next, newCarry)
            return node
            
        }
        return nil
    }
}

let s = SingleLinkedList()
s.insert(end: 1)
s.insert(end: 2)
s.insert(end: 3)
s.insert(end: 4)

//SingleLinkedList.printList(s.head)

let rN = SingleLinkedList.reverseIterative(s.head)

SingleLinkedList.printList(rN)


