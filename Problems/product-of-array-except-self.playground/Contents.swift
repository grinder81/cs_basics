import UIKit

// https://leetcode.com/problems/product-of-array-except-self/

class Solution {
    // Analysis:
    // [1, 2, 3, 4, 5]
    // if I have 1 * 2 = 2 and 4 * 5 = 20
    // then I can say 2 * 20 = 40 is the ans for 3
    // which mean I need to forward multiplication
    // and backword multiplication
    
    private func methodUsingDoubleArray(_ nums: [Int]) -> [Int] {
        var forward     = Array(nums)
        var backward    = Array(nums)
        
        let n = nums.count
        
        var i = 1
        while i < n {
            forward[i] = forward[i - 1] * nums[i]
            i += 1
        }
        
        var j = n - 2
        while j >= 0 {
            backward[j] = backward[j + 1] * nums[j]
            j -= 1
        }
        
        var result: [Int] = []
        var k = 0
        while k < n {
            let f = k - 1 >= 0 ? forward[k - 1] : 1
            let b = k + 1 < n ? backward[k + 1] : 1
            result.append(f * b)
            k += 1
        }
        return result
    }
    
    // Bases on the previous solution
    // We can say: F(i) = F(i - 1) * F(i + 1)
    //  1. We can find i = 0 value and i = n -1 value
    //  2. These are the base case
    // That's a wrong analysis!!!!
    
    // Simple method:
    // One pass by skipping current nums[i] in forward
    // Another pass from backward by skipping current nums[i]
    
    private func methodMemoization(_ nums: [Int]) -> [Int] {
        let n = nums.count
        
        var output = Array(repeating: 1, count: n)
        
        var i = 0
        var l = 1
        while i < n {
            output[i] *= l
            l *= nums[i]
            i += 1
        }

        var j = n - 1
        var r = 1
        while j >= 0 {
            output[j] *= r
            r *= nums[j]
            j -= 1
        }
        
        return output
    }
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        return methodMemoization(nums)
    }
}

let s = Solution()
s.productExceptSelf([1,2,3,4])
