import UIKit

// https://leetcode.com/problems/sliding-window-maximum/
// O((n - k + 1))
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    guard nums.count > 0 else { return [] }
    
    var output: [Int] = []
    var deQueue: [Int] = []
    let n = nums.count
    for index in 0..<k {
        while deQueue.count > 0 && nums[index] >= nums[deQueue.last!] {
            deQueue.removeLast()
        }
        deQueue.append(index)
    }
    for index in k..<n {
        output.append(nums[deQueue.first!])
        
        // Anything outside window need to remove
        while deQueue.count > 0 && index - k  >= deQueue.first! {
            deQueue.removeFirst()
        }
        
        // Remove anything less or equal to current index value
        while deQueue.count > 0 && nums[index] >= nums[deQueue.last!] {
            deQueue.removeLast()
        }
        deQueue.append(index)
    }
    
    output.append(nums[deQueue.first!])
    return output
}

//maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)
maxSlidingWindow([10, 9, 8, 7, 6, 5, 4, 3], 3)

// O(n * k)
func maxSlidingWindowSimple(_ nums: [Int], _ k: Int) -> [Int] {
    guard nums.count > 0 else {
        return []
    }
    
    let n = nums.count
    var output: [Int] = []

    typealias Pair = (value: Int, index: Int)
    var maxP = Pair(value: nums[0], index: 0)
    for i in 1..<k {
        if nums[i] >= maxP.value {
            maxP = Pair(value: nums[i], index: i)
        }
    }
    
    var j = k
    while j < n {
        output.append(maxP.value)
        
        // if maxP.index is inside window which is <= j
        // then max(maxP.value, nums[j])
        // else loop from maxP.index + 1 to j to find new maxP
        
        if (j - maxP.index) < k {
            maxP = nums[j] >= maxP.value ? Pair(value: nums[j], index: j) : maxP
        } else {
            var l = maxP.index + 1
            maxP = Pair(value: nums[j], index: j)
            while l < j {
                if nums[l] >= maxP.value {
                    maxP = Pair(value: nums[l], index: l)
                }
                l += 1
            }
        }
        j += 1
    }
    output.append(maxP.value)
    return output
}

//maxSlidingWindowSimple([1,3,-1,-3,5,3,6,7], 3)
maxSlidingWindowSimple([10, 9, 8, 7, 6, 5, 4, 3], 3)

//maxSlidingWindowSimple([1,-1], 1)
