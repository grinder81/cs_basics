import UIKit

// https://leetcode.com/problems/container-with-most-water/

// Analysis:
// It's trying find max value.
//  1. Initial thinking should 0 to n-1 could be the max range
//  2. If that's the case then it's giving hints to start 2 pointer
//  3. If 2 pointer then
//      a. what is the condision for l?
//      b. what is the condision for r?
//  4. Most of the time there should be a value to compare based on that l or r should move

class Solution {
    private func methodIndexBased(_ height: [Int]) -> Int {
        let n = height.count
        
        var l = 0
        var r = n - 1
        var maxArea = 0
        
        while l < r {
            // Height is everything here. We need min height of l and r
            let h = min(height[l], height[r])
            let area = h * (r - l)
            maxArea = max(maxArea, area)
            
            // like we analyized, h is the core comparision
            // l and r try to come in middle based on h value
            while l < r, height[l] <= h {
                l += 1
            }
            
            while l < r, height[r] <= h {
                r -= 1
            }
        }
        return maxArea
    }
    
    func maxArea(_ height: [Int]) -> Int {
        return methodIndexBased(height)
    }
}

let s = Solution()
s.maxArea([1,8,0])
