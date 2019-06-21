import UIKit

// https://leetcode.com/problems/swap-nodes-in-pairs/submissions/


public class ListNode {
 public var val: Int
 public var next: ListNode?
 public init(_ val: Int) {
     self.val = val
     self.next = nil
 }
}

class Solution {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let dummy = head?.next
        var prev: ListNode? = nil
        var current: ListNode? = head
        var next: ListNode? = head?.next
        
        while let a = current, let b = next {
            a.next  = b.next
            b.next  = a
            prev?.next = b
            
            prev = a
            current = a.next
            next = current?.next
        }
        
        return dummy
    }
}
