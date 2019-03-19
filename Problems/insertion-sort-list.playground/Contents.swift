import UIKit

// https://leetcode.com/problems/insertion-sort-list/

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// O(n^2) time
class Solution {
    
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        
        var current = head?.next
        
        // Start head as a sorted list head
        var sortedHead = head
        head?.next = nil
        
        while current != nil  {
            
            //print(current?.val)
            
            // Pick the current as node to place in correct position
            let node = current
            
            // update current by next element
            current = current?.next
            
            // disconnect node to be placed next connection
            // now that node will be orpahned
            node?.next = nil
            
            // start from sorted head and find
            // after that node will be placed
            var l = sortedHead
            var after: ListNode? = nil
            while l != nil, l!.val < node!.val {
                after = l
                l = l?.next
            }
            //print("\(node?.val) \(l?.val)")
            // node next should be selected node next
            // like h = 3->5 and n = 4 then l = 3, 4->5
            // or h = 3->5 and n = 2 then l = 3 which is head 2->3
            if after == nil {
                // or h = 3->5 and n = 2 then l = 3 which is head 2->3
                node?.next = sortedHead
                sortedHead = node
            } else {
                // like h = 3->5 and n = 4 then l = 3, 4->5
                node?.next = after?.next
                after?.next = node
            }
        }
        return sortedHead
    }
}
