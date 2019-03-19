import UIKit

// https://leetcode.com/problems/3sum-closest/

// Analysis:
// This is just another form of 3 Sum!!!!
// a + b + c = t
// a + b = t - c
// So when we get a + b == t - c then that's the best result and return t
// if a + b < t - c then min will be d = (t-c) - a - b
// if a + b > t - c then min will be d = a + b + c - t
// [0, 1, 1, 1]
//


class Solution {
    

    private func methodThreeSum(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        var m = Int.max
        var result = 0
        var i = 0
        while i < n - 2 {
            let sum = target - nums[i]
            var l = i + 1
            var r = n - 1
            while l < r {
                if sum == nums[l] + nums[r] {
                    return target
                } else if sum < nums[l] + nums[r] {
                    let d = nums[l] + nums[r] + nums[i] - target
                    if d < m {
                        m = min(m, d)
                        result = nums[l] + nums[r] + nums[i]
                    }
                    r -= 1
                } else {
                    let d = target - nums[l] - nums[r] - nums[i]
                    if d < m {
                        m = min(m, d)
                        result = nums[l] + nums[r] + nums[i]
                    }
                    l += 1
                }
            }
            i += 1
        }
        return result
    }
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else { return 0 }
        return methodThreeSum(nums.sorted(), target)
    }
}

let s = Solution()
s.threeSumClosest([1, 1, 1, 0], -100)
