import UIKit

// O(n^3)

func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    guard nums.count > 0 else { return [] }
    
    let array = nums.sorted{ $0 < $1 }
    let n = array.count
    var result: [[Int]] = []
    var i = 0
    while i < n - 3 {
        var j = i + 1
        while j < n - 2 {
            // a + b + c + d = t
            // c + d = t - (a + b)
            let sum = target - (array[i] + array[j])
            var l = j + 1
            var r = n - 1
            
            while l < r {
                if sum == (array[l] + array[r]) {
                    result.append([array[i], array[j], array[l], array[r]])
                    while l < r, array[l] == array[l + 1] { l += 1 }
                    while l < r, array[r] == array[r - 1] { r -= 1 }
                    l += 1
                    r -= 1
                } else if sum < (array[l] + array[r]) {
                    r -= 1
                } else {
                    l += 1
                }
            }
            while j < n - 1, array[j] == array[j + 1] { j += 1 }
            j += 1
        }
        
        while i < n - 1, array[i] == array[i + 1] { i += 1 }
        i += 1
    }
    
    return result
}
