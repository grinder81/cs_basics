import UIKit

func twoSum(_ nums: [Int], _ startIndex: Int, _ endIndex: Int, _ target: Int) -> [[Int]] {
    var result: [[Int]] = []
    var l = startIndex
    var r = endIndex
    while l < r {
        let sum = nums[l] + nums[r]
        if sum == target {
            result.append([nums[l], nums[r]])
            while l < r, nums[l] == nums[l + 1] { l += 1 }
            while l < r, nums[r] == nums[r - 1] { r -= 1 }
            l += 1
            r -= 1
        } else if sum < target {
            l += 1
        } else {
            r -= 1
        }
    }
    return result
}

// Nums is a sorted array
func kSum(_ nums: [Int], _ startIndex: Int, _ endIndex: Int, _ target: Int, _ k: Int) -> [[Int]] {
    if k <= 2 {
        return twoSum(nums, startIndex, endIndex, target)
    }
    var result: [[Int]] = []
    var i = startIndex
    while i <= endIndex {
        let v = nums[i]
        let r = kSum(nums, i + 1, endIndex, target - v, k - 1)
        r.forEach { t in
            var e: [Int] = [v]
            e.append(contentsOf: t)
            result.append(e)
        }
        while i < endIndex, nums[i] == nums[i + 1] { i += 1 }
        i += 1
    }
    return result
}

var a = [-1, 0, 1, 2, -1, -4]
kSum(a.sorted{ $0 < $1 }, 0, 5, 0, 3)
