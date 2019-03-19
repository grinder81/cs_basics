import UIKit

// https://leetcode.com/problems/sort-list/


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    
    private func split(_ node: ListNode?, _ left: inout ListNode?, _ right: inout ListNode?) {
        var slow = node
        var fast = node
        
        var prev: ListNode? = nil
        
        while fast != nil && fast?.next != nil {
            prev = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        left = node
        right = slow
        
        // Cut the link
        prev?.next = nil
    }
    
    private func sortedMerge(_ a: ListNode?, _ b: ListNode?) -> ListNode? {
        guard let a = a else { return b }
        guard let b = b else { return a }
        
        var result: ListNode? = nil
        
        if a.val <= b.val {
            result = a
            result?.next = sortedMerge(a.next, b)
        } else {
            result = b
            result?.next = sortedMerge(a, b.next)
        }
        
        return result
    }
    
    private func sort(_ node: inout ListNode?) {
        // 1. Boundary check
        if node == nil || node?.next == nil {
            return
        }
        
        // 2. Divide the list by 1/2
        var a: ListNode?
        var b: ListNode?
        split(node, &a, &b)
        
        // 3. sort first 1/2
        sort(&a)
        
        // 4. sort second 1/2
        sort(&b)
        
        // 5 merge sorted list
        node = sortedMerge(a, b)
    }
    
    func sortList(_ head: ListNode?) -> ListNode? {
        var node = head
        sort(&node)
        return node
    }
}

