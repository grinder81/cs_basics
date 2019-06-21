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
    
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        guard head != nil else { return head }
        
        var beforeDummy: ListNode? = ListNode(0)
        var before: ListNode? = beforeDummy
        var afterrDummy: ListNode? = ListNode(0)
        var after: ListNode? = afterrDummy
        
        var current = head
        while current != nil, let value = current?.val {
            if value < x {
                before?.next = current
                before = before?.next
            } else {
                after?.next = current
                after = after?.next
            }
            current = current?.next
        }
        
        after?.next = nil
        before?.next = afterrDummy?.next
        
        return beforeDummy?.next
    }
}
