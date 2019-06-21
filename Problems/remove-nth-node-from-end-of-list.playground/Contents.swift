public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil else { return nil }
        
        var dummy: ListNode?
        
        var slow: ListNode?
        var fast: ListNode?
        
        dummy = ListNode(0)
        
        slow = dummy
        fast = dummy
        slow?.next = head
        
        var count = 1
        while count <= n + 1 {
            count += 1
            fast = fast?.next
        }
        while fast != nil {
            slow = slow?.next
            fast = fast?.next
        }
        slow?.next = slow?.next?.next
        return dummy?.next
    }
}
