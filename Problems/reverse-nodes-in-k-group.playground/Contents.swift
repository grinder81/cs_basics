import UIKit

public class ListNode {
 public var val: Int
 public var next: ListNode?
 public init(_ val: Int) {
     self.val = val
     self.next = nil
 }
}

class Solution {
    
    typealias Node = ListNode
    
    func reverse(_ node: ListNode?) -> ListNode? {
        
        var dummy: ListNode?
        var pre: ListNode?
        var cur: ListNode?
        
        dummy = ListNode(0)
        dummy?.next = node
        pre = dummy

        cur = pre?.next
        
        while let next = cur?.next {
            cur?.next = next.next
            next.next = pre?.next
            pre?.next = next
        }
        
        return dummy?.next
    }
    
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, k > 1 else { return head }
        var count = 1
        var current = head
        
        while count < k, let next = current?.next {
            count += 1
            current = next
        }
        
        if count == k {
            let next = current?.next
            current?.next = nil
            let n = reverse(head)
            head?.next = reverseKGroup(next, k)
            return n
        }
        return head
    }
    
    static func printList(_ node: Node?) {
        var current = node
        while let next = current?.next {
            print(current?.val)
            current = next
        }
        print(current?.val)
    }

}

let n1 = ListNode(1)
let n2 = ListNode(2)
let n3 = ListNode(3)
let n4 = ListNode(4)
let n5 = ListNode(5)

n1.next = n2
n2.next = n3
n3.next = n4
n4.next = n5


let s = Solution()
//Solution.printList(s.reverse(n1))

let n = s.reverseKGroup(n1, 3)
print("Final: ")
Solution.printList(n)
