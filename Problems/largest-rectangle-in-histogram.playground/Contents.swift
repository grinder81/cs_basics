import UIKit

// https://leetcode.com/problems/largest-rectangle-in-histogram/

class Solution {
    // Analysis:
    //
    private func methodStack(_ heights: [Int]) -> Int {
        let n = heights.count
        var i = 0
        var stack: [Int] = []
        var maxArea = 0
        while i < n {
            // if stack is empty or current height is >= stack top
            // which mean we are still in ascending order
            if stack.isEmpty || heights[stack.last!] <= heights[i] {
                stack.append(i)
                i += 1
            } else {
                // Top of the stack is the height always smallest one which is <= h[i - 1]
                // Width is (current Index - stack top - 1)
                let top = stack.removeLast()
                let right = i - 1
                let left = (stack.isEmpty ? 0 : stack.last! + 1)
                let width = right - left + 1
                let area = heights[top] * width
                maxArea = max(maxArea, area)
            }
        }
        
        while !stack.isEmpty {
            let top = stack.removeLast()
            let right = i - 1
            let left = (stack.isEmpty ? 0 : stack.last! + 1)
            let width = right - left + 1
            maxArea = max(maxArea, area)
        }
        
        return maxArea
    }
    
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard heights.count > 0 else { return 0 }
        return methodStack(heights)
    }
}
