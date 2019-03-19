import UIKit

// https://leetcode.com/problems/trapping-rain-water/

// Analysis:
// If h[index] <= h[l] where l is the last known max left height
//  then we can keep adding item to stack to find the height later
// else we hit a heighr bar which is a new left max height
//  - calcualte area only for current height and new max height
// If h.count < 2 then return 0

class Solution {
    // O(n)
    private func methodIndexBased(_ height: [Int]) -> Int {
        guard height.count > 1 else { return 0 }
        
        let n = height.count
        
        var l = 0
        var r = n - 1
        
        // We can divide in 2 part
        // 1. When h[l] < h[r]
        //  a. [3, 2, 3, 5, 10]
        //  b. If h[l] >= leftMax which mean we have a new leftMax
        //  c. Or we can calculate the area as (lMax - h[l])
        //  d. Move to next l
        // 2. When h[l] >= h[r]
        //  a. [10, 5, 3, 2, 5]
        //  b. If h[r] >= rMax then new rMax
        //  c. Or area = rMax - h[r]
        //  d. Move down r by 1
        
        // Happy case:
        // 1. [1, 0, 0, 2]
        // 2. [2, 0, 0, 1]
        // 3. [1, 0, 2, 0, 1]
        
        // UnHappy case:
        //  1. [2, 1, 1, 1, 0]
        //  2. [1, 1, 1]
        //  3. [1, 1, 2, 1, 1]
        
        var lMax = 0
        var rMax = 0
        var area  = 0
        
        while l < r {
            if height[l] < height[r] {
                if height[l] >= lMax {
                    lMax = height[l]
                } else {
                    area += (lMax - height[l])
                }
                l += 1
            } else {
                if height[r] >= rMax {
                    rMax = height[r]
                } else {
                    area += (rMax - height[r])
                }
                r -= 1
            }
        }
        return area
    }
    
    // O(n + n)
    private func methodStackBased(_ height: [Int]) -> Int {
        guard height.count > 1 else { return 0 }
        
        let n = height.count
        var index = 0
        var l = 0
        var area = 0
        
        var stack: [Int] = []
        
        while index < n {
            // make sure we are descending order or equal or empty then keep going
            if stack.count == 0 || height[index] <= height[stack.last!] {
                stack.append(index)
                index += 1
            } else {
                // We want calcualte trap water for this index
                // To do that we need r - 1
                let r = stack.removeLast()
                
                // Check we have r - 1 information
                if stack.count > 0 {
                    let r_1 = stack.last!
                    // Find the min height of (r - 1) and index which is
                    let h = min(height[index], height[r_1])
                    // This is the only effective height in calculation
                    // We are doing for each segment, not for whole at a time
                    let hDiff = (h - height[r])
                    
                    area += (index - r_1 - 1) * hDiff
                }
            }
        }
        return area
    }
    
    func trap(_ height: [Int]) -> Int {
        return methodStackBased(height)
    }
}
