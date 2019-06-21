import UIKit

// https://leetcode.com/problems/max-sum-of-rectangle-no-larger-than-k/

// Analysis: We can solve the porblem using max subarray problem
// Consider L and R to iterator change the size of rect in terms of column
// Then we can go from up to down to find max

class Solution {
    
    private func maxSubArrayBF(_ array: [Int], _ k: Int) -> Int {
        let n = array.count

        var maxSum = Int.min
        for i in 0..<n {
            var sum = 0
            for j in i..<n {
                sum += array[j]
                if sum <= k {
                    maxSum = max(maxSum, sum)
                    // If we find then we are done
                    if maxSum == k {
                        return k
                    }
                }
            }
        }
        return maxSum
    }
    
    private func maxSubArrayDC(_ array: [Int], _ l: Int, _ r: Int, _ k: Int) -> Int {
        if l == r {
            return array[l]
        }
        let m = (l + r) / 2
        let lMax = maxSubArrayDC(array, l, m, k)
        let rMax = maxSubArrayDC(array, m + 1, r, k)
        let mMax = maxSubArrayMerge(array, l, m, r, k)
        return max(mMax, max(lMax, rMax))
    }
    
    private func maxSubArrayMerge(_ array: [Int], _ l: Int, _ m: Int, _ r: Int, _ k: Int) -> Int {
        var sum = 0
        var lSum = Int.min
        for i in stride(from: m, through: l, by: -1) {
            sum += array[i]
            lSum = max(sum, lSum)
        }
        
        sum = 0
        var rSum = Int.min
        for i in stride(from: m + 1, through: r, by: 1) {
            sum += array[i]
            rSum = max(sum, rSum)
        }
        
        if lSum == k {
            return k
        }

        if rSum == k {
            return k
        }

        return lSum + rSum
    }
    
    
    func maxSubArrayDP(_ array: [Int], _ k: Int) -> Int {
        let n = array.count
        var cache = Array<Int>(repeating: 0, count: n)
        cache[0] = array[0]
        for i in stride(from: 1, to: n, by: 1) {
            cache[i] = max(array[i], array[i] + cache[i - 1])
        }
        
        var q = array[0]
        for i in stride(from: 1, to: n, by: 1) {
            if array[i] + cache[i - 1] <= k {
                let m = max(array[i], array[i] + cache[i - 1])
                q = max(q, m)
                if q == k {
                    return k
                }
            }
        }
        return q
    }
    
    func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
        // number of row
        let n = matrix.count
        // number of column
        let m = matrix[0].count
        
        var result = Int.min
        
        for l in 0..<m {
            var sum = Array(repeating: 0, count: n)
            for r in l..<m {
                // For column r go through all row
                for i in 0..<n {
                    sum[i] += matrix[i][r]
                }
                // find max Sum
                //let maxSum = maxSubArrayBF(sum, k)
                //let maxSum = maxSubArrayDC(sum, 0, sum.count - 1, k)
                //let maxSum = maxSubArrayDnCInternal(sum, 0, sum.count - 1)
                let maxSum = maxSubArrayDP(sum, k)
                print("\(maxSum) \(sum)")
                if maxSum <= k {
                    result = max(maxSum, result)
                    if result == k {
                        return k
                    }
                }
            }
        }
        return result
    }
}

let s = Solution()
s.maxSumSubmatrix([[5,-4,-3,4],[-3,-4,4,5],[5,1,5,-4]], 8)
