import UIKit

// https://leetcode.com/problems/majority-element/

// O(nlogn)
func majorityElement(_ nums: [Int]) -> Int {
    let nums = nums.sorted{ $0 < $1 }
    let n = nums.count
    return nums[n/2]
}

// O(n)
func majorityElement2(_ nums: [Int]) -> Int {
    var major = nums[0]
    var count = 1
    var i = 1
    while i < nums.count {
        if count == 0 {
            count += 1
            major = nums[i]
        } else if major == nums[i] {
            count += 1
        } else {
            count -= 1
        }
    }
    return major
}

