import UIKit

// https://leetcode.com/problems/shortest-subarray-with-sum-at-least-k/

// Analysis: We can generate all subsequent array and then
// sum
class Solution {
    
    private func methodSimple(_ A: [Int], _ K: Int) -> Int {
        let n = A.count
        var maxCount = -1
        for i in 0..<n {
            var sum = 0
            for j in i..<n {
                sum += A[j]
                if sum == K {
                    print("\(i) \(j)")
                    return j - i + 1
                }
            }
        }
        return -1
    }
    
    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        return methodSimple(A, K)
    }
}

let s = Solution()
s.shortestSubarray([48,99,37,4,-31], 140)
