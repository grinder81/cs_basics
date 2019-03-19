import UIKit

// https://leetcode.com/problems/maximum-product-subarray/

class Solution {
    // Analysis:
    // We should be able to use DNC
    // Left max or right max or it could be left * right
    
    // Failed: The reason DNC won't because of these:
    //  1. '-' will change the total value which mean in one
    //      1/2 we have less due to '-' in other 1/2 we have another
    //      '-' then in total it become positive and it could be
    //      high. DNC is a gready approach so you won't be able to
    //      took right dicision
    
    /*
    
    private func methodDNC(_ nums: [Int], _ l: Int, _ r: Int) -> Int {
        if l == r {
            return nums[l]
        }
        let m = (r + l) / 2
        return max(max(methodDNC(nums, l, m), methodDNC(nums, m + 1, r)),
                   merge(nums, l, m, r))
    }
    
    private func merge(_ nums: [Int], _ l: Int, _ m: Int, _ r: Int) -> Int {
        var lm = nums[m]
        var i = m - 1
        while i >= l {
            lm *= nums[i]
            i -= 1
        }
        
        var rm = nums[m + 1]
        var j = m + 2
        while j <= r {
            rm *= nums[j]
            j += 1
        }
        return max(max(lm, rm), lm * rm)
    }
    */
    
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
    }
}

let s = Solution()
s.maxProduct([2,-5,-2,-4,3])
