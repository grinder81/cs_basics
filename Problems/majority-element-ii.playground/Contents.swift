import UIKit

// https://leetcode.com/problems/majority-element-ii/

class Solution {
    func majorityElement(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else { return nums }
        
        let n = nums.count
        let k = n / 3
        
        var m1 = nums[0]
        var m2 = nums[0]
        var c1 = 0
        var c2 = 0
        
        for item in nums {
            if item == m1 {
                c1 += 1
            } else if item == m2 {
                c2 += 1
            } else if c1 == 0 {
                c1 += 1
                m1 = item
            } else if c2 == 0 {
                c2 += 1
                m2 = item
            } else {
                c1 -= 1
                c2 -= 1
            }
        }
        
        c1 = 0
        c2 = 0
        // I missed that part.
        // Almost got everything but couldn't think that part :(
        for item in nums {
            if item == m1 {
                c1 += 1
            } else if item == m2 {
                c2 += 1
            }
        }
        
        var result: [Int]  = []
        if c1 > k {
            result.append(m1)
        }
        if c2 > k {
            result.append(m2)
        }
        return result
    }
}
