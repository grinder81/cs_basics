import UIKit

// O(n)
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count > 0 else { return [] }
    
    let n = nums.count
    
    var map: [Int: Int] = [:]
    var index = 0
    
    while index < n {
        // x + y = target
        // x = target - y
        let x = target - nums[index]
        if let v = map[x] {
            return [v, index]
        }
        map[nums[index]] = index
        index += 1
    }
    
    return []
}
