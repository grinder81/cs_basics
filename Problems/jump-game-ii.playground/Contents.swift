import UIKit

// https://leetcode.com/problems/jump-game-ii/

class Solution {
    
    let MAX = Int.max - 100

    // O(n)
    private func methodBFS(_ nums: [Int]) -> Int {
        let n = nums.count
        
        guard n > 1 else { return 0 }
        
        // Indicate what is the max value of current level
        var level            = 0
        var indexSoFar       = 0
        var currentMaxIndex  = 0
        
        // At current level how many node exist
        var currentLevelNodeCount = currentMaxIndex - indexSoFar + 1
        
        // [2, 3, 1, 1, 3]
        // [2, 3, 5, 1, 1, 1, 1, 2]
        //          0
        //      1       2
        //                  2 + 5 = 7 will be the ans
        // [2, 2, 4, 1, 1, 1, 2]
        // BSF or level search always consider closest one first
        //  1. You can find shortest path only from your best neighbor
        //  2. neighbor Index + neighbor[index] will bring the best ans
        
        while currentLevelNodeCount > 0  {
            level += 1
            var newMaxIndex = 0
            // Find the max jump we can do from current level
            while indexSoFar <= currentMaxIndex {
                newMaxIndex = max(newMaxIndex, indexSoFar + nums[indexSoFar])
                
                // If we reach then yes we found it
                if newMaxIndex >= n - 1 {
                    return level
                }
                indexSoFar += 1
            }
            currentMaxIndex = newMaxIndex
            currentLevelNodeCount = currentMaxIndex - indexSoFar + 1
        }
        
        return 0
    }
    
    private func methodDP(_ nums: [Int]) -> Int {
        let n = nums.count
        var memo = Array(repeating: MAX, count: nums.count)
        
        memo[n - 1] = 0
        for index in stride(from: n - 2, through: 0, by: -1)
        {
            var q = MAX
            var i = 1
            let u = nums[index] == 0 ? 1 : nums[index]
            while i <= u {
                let k = index + i
                if k == n - 1 {
                    q = 1
                    break
                } else {
                    q = min(q, memo[k] + 1)
                }
                i += 1
            }
            memo[index] = q
        }
        return memo[0]
    }
    
    private func methodRecMemo(_ nums: [Int], _ index: Int, _ memo: inout [Int]) -> Int {
        if index >= nums.count {
            return MAX
        }
        if index == nums.count - 1 {
            return 0
        }
        
        if memo[index] >= 0 {
            return memo[index]
        }
        
        var q = MAX
        var i = 1
        let u = nums[index] == 0 ? 1 : nums[index]
        while i <= u {
            q = min(q, methodRecMemo(nums, index + i, &memo) + 1)
            i += 1
        }
        memo[index] = q
        return memo[index]
    }
    
    // This is exponential runtime but it solve the problem
    private func methodRec(_ nums: [Int], _ index: Int) -> Int {
        if index >= nums.count {
            return MAX
        }
        if index == nums.count - 1 {
            return 0
        }
        var q = MAX
        var i = 1
        let u = nums[index] == 0 ? 1 : nums[index]
        while i <= u {
            q = min(q, methodRec(nums, index + i) + 1)
            i += 1
        }
        return q
    }
    
    func jump(_ nums: [Int]) -> Int {
        //var memo = Array(repeating: -1, count: nums.count)
        //return methodRec(nums, 0, &memo)
        //return methodRec(nums, 0)
        //return methodDP(nums)
        return methodBFS(nums)
    }
    
}

let s = Solution()
s.jump([2,10,1,1,4])
