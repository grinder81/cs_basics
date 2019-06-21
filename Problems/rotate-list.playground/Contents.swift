public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, k > 0 else { return head }
        
        var n = 1
        var cur = head
        var tail = head
        while let next = cur?.next {
            n += 1
            cur = next
        }
        tail = cur
        
        let m = k % n
        
        if m == 0 {
            return head
        }
        
        var dummy: ListNode?
        var slow: ListNode?
        var fast: ListNode?
        
        dummy = ListNode(0)
        slow = dummy
        fast = dummy
        slow?.next = head
        
        var count = 1
        while count <= m + 1 {
            count += 1
            fast = fast?.next
        }
        
        while fast != nil {
            slow = slow?.next
            fast = fast?.next
        }
        dummy?.next = slow?.next
        slow?.next = nil
        tail?.next = head
        return dummy?.next
    }
}
