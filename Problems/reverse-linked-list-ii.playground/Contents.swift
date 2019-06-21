import UIKit

//https://leetcode.com/problems/reverse-linked-list-ii/

 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
 }

class Solution {
    
    private func methodOne(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        guard head != nil else { return head }
        
        var a: ListNode?
        var b: ListNode?
        
        var count = 1
        var current = head
        while current != nil {
            if count == m {
                a = current
                break
            }
            count += 1
            current = current?.next
        }
        
        while current != nil {
            if count == n {
                b = current
                break
            }
            count += 1
            current = current?.next
        }
        
        let r = n - m
        var array: [Int] = []
        count = 0
        current = a
        while count != r {
            array.append(current!.val)
            count += 1
            current = current?.next
        }
        array.append(current!.val)
        array.reverse()
        
        count = 0
        current = a
        while count != r {
            current?.val = array[count]
            count += 1
            current = current?.next
        }
        current?.val = array[count]
        return head
    }
    
    private func recursion(_ left: inout ListNode?, _ right: inout ListNode?, _ keepSwaping: inout Bool, _ m: Int, _ n: Int) {
        if n == 1 {
            return
        }
        right = right?.next
        
        if m > 1 {
            left = left?.next
        }
        recursion(&left, &right, &keepSwaping, m - 1, n - 1)
        
        if left === right || right?.next === left {
            keepSwaping = false
        }
        
        if keepSwaping {
            swap(&left!.val, &right!.val)
            left = left?.next
        }
    }
    
    private func methodTwo(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        var l = head
        var r = head
        var b = true
        recursion(&l, &r, &b, m, n)
        
        return head
    }
    
    private func methodThree(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        guard head != nil else { return head }
        
        var dummy: ListNode?
        var pre: ListNode?
        
        dummy = ListNode(0)
        dummy?.next  = head
        pre = dummy
        
        var index = 0
        while index < m - 1 {
            pre = pre?.next
            index += 1
        }
        var start   = pre?.next
        var then    = start?.next
        
        // DUMMY->PRE->START->THEN
        index = 0
        while index < (n - m) {
            start?.next  = then?.next
            then?.next   = pre?.next
            pre?.next    = then
            then         = start?.next
            
            index += 1
        }
        return dummy?.next
    }
    
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        //return methodOne(head, m, n)
        //return methodTwo(head, m, n)
        return methodThree(head, m, n)
    }
}
