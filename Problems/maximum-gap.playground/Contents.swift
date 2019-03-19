import UIKit

// https://leetcode.com/problems/maximum-gap/

// Learn: Bucket sort and Radix sort
// https://leetcode.com/problems/maximum-gap/discuss/50642/Radix-sort-solution-in-Java-with-explanation



class Solution {
    
    // O(nlogn)
    private func methodUsingSort(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return 0 }
        let a = nums.sorted{ $0 > $1 }
        let n = a.count
        var maxV = Int.min
        var i = 0
        while i < (n - 1) {
            maxV = max(maxV, (a[i] - a[i + 1]))
            i += 1
        }
        return maxV
    }
    
    func maximumGap(_ nums: [Int]) -> Int {
        return methodUsingSort(nums)
    }
}
