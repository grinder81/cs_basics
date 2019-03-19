import UIKit

// https://leetcode.com/problems/subarray-sum-equals-k/

class Solution {
    
    private func methodON(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var map: [Int: Int] = [:]
        var count = 0
        var sum = 0
        
        map[0] = 1
        for i in 0..<n {
            sum += nums[i]
            if let v = map[sum - k] {
                count += v
            }
            map[sum] = ((map[sum] ?? 0) + 1)
        }
        return count
    }
    
    private func methodNSQR(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var count = 0
        for i in 0..<n {
            var sum = 0
            for j in i..<n {
                sum += nums[j]
                if sum == k {
                    count += 1
                }
            }
        }
        return count
    }
    
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        return methodNSQR(nums, k)
    }
}
