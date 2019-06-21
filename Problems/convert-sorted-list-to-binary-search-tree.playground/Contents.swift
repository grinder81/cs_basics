import UIKit


Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


class Solution {
    
    func middleElement(_ head: ListNode? ) -> ListNode? {
        guard head != nil else { return head }
        
        var prev: ListNode?
        var slow: ListNode?
        var fast: ListNode?
        
        slow = head
        fast = head
        
        while fast != nil && fast?.next != nil {
            prev = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        //disconnect in the middle
        prev?.next = nil
        return slow
    }
    
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        guard head != nil else { return nil }
        
        // find middle
        let mid = middleElement(head)
        
        // create tree node
        let node = TreeNode(mid!.val)
        
        if head === mid {
            return node
        }
        
        // recurse from head for node.left
        node.left = sortedListToBST(head)
        // recurse from mid.next for node.right
        
        node.right = sortedListToBST(mid?.next)
        // return node
        return node
    }
}
