
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard head != nil else { return nil }
        
        var dummy: ListNode?
        var pre: ListNode?
        var cur: ListNode?
        
        dummy = ListNode(0)
        dummy?.next = head
        pre = dummy
        cur = head
        
        while cur != nil {
            var node = cur
            while let tail = node?.next, let value = node?.val, value == tail.val {
                node = tail
            }
            if cur === node {
                pre = pre?.next
            } else {
                pre?.next = node?.next
            }
            cur = node?.next
        }
        
        return dummy?.next
    }
}
