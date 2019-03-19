import UIKit

// https://leetcode.com/problems/wiggle-sort/

class Solution {
    func wiggleSort(_ nums: inout [Int]) {
        let n = nums.count
        var i = 1
        while i < n {
            if (i % 2 == 1) && nums[i] < nums[i - 1] {
                nums.swapAt(i, i - 1)
            }
            
            if (i % 2 == 0) && nums[i] > nums[i - 1] {
                nums.swapAt(i, i - 1)
            }
            i += 1
        }
    }
}
