import UIKit

// https://leetcode.com/problems/maximal-rectangle/


class Solution {
    
    private func methodHistogram(_ matrix: [[Character]]) -> Int {
        let n = matrix.count        // row count
        let m = matrix[0].count     // coloum count
        
        var heights = Array(repeating: 0, count: m)
        var result = 0
        for r in 0..<n {
            for c in 0..<m {
                heights[c] = matrix[r][c] == "1" ? heights[c] + 1 : 0
            }
            // We have the heights here we can apply area calculation
            result = max(result, calculateArea(heights))
        }
        return result
    }
    
    // We have histogram bar from where we can find max rect area
    // We can push item in stack till bar height decreasing order
    // if h[stack.top] <= h[i]
    //  like [2, 3, 4, 5, 6, 2].
    // otherwise we pop item and then calculate area
    //  [2, 3, 4, 5, 6, 2] at item 2 we pop 6 as our current height
    //  find right index as i - 1 and left index could be:
    //      stack.top + 1
    //      then w = right - left + 1
    //  If stack is empty then width is i which is from begining of the stack to current index
    
    private func calculateArea(_ heights: [Int]) -> Int {
        var maxArea = 0
        var stack: [Int] = []
        let n = heights.count
        var i = 0
        while i < n {
            if stack.isEmpty || heights[stack.last!] <= heights[i] {
                stack.append(i)
                i += 1
            } else {
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
            let area = heights[top] * width
            maxArea = max(maxArea, area)
        }
        return maxArea
    }
    
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0 else { return 0 }
        return methodHistogram(matrix)
    }
}

let s = Solution()
s.maximalRectangle([
    ["1","0","1","0","0"],
    ["1","0","1","1","1"],
    ["1","1","1","1","1"],
    ["1","0","0","1","0"]
    ])
