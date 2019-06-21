import UIKit

// https://leetcode.com/problems/daily-temperatures/

class Solution {
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        guard !T.isEmpty else {
            return []
        }
        let n = T.count
        var result = Array(repeating: 0, count: T.count)
        var stack: [Int] = []
        var index = 0
        while index < n {
            if stack.isEmpty || T[stack.last!] >= T[index] {
                stack.append(index)
                index += 1
            } else {
                let top = stack.removeLast()
                result[top] = index - top
            }
        }
        return result
    }
}

let s = Solution()
s.dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73])

