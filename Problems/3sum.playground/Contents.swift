import UIKit

// Time: O(n^2)
// Took 3 attempt to solve it BAD!!!
func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 0 else { return [] }
    let array = nums.sorted{ $0 < $1 }
    let n = array.count
    var result: [[Int]] = []
    var i = 0
    while i < n-2 {
        let a = array[i] * -1
        var l = i + 1
        var r = n - 1
        while l < r {
            let b = array[l]
            let c = array[r]
            if  a == b + c {
                result.append([array[i], array[l], array[r]])
                // Missed that duplicate avoiding
                // [-2, 0, 0, 2, 2]
                while (l + 1) < r, array[l] == array[l + 1] { l += 1 }
                while (l + 1) < r, array[r] == array[r - 1] { r -= 1 }
                l += 1
                r -= 1
            }
            else if a < b + c {
                r -= 1
            } else {
                l += 1
            }
        }
        // Missed that duplicate avoiding as well
        while i < n - 1, array[i] == array[i + 1] { i += 1 }
        i += 1
    }
    return result
}
