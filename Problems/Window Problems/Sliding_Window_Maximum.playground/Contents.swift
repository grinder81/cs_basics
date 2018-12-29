import UIKit

// https://leetcode.com/problems/sliding-window-maximum/

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

maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)
