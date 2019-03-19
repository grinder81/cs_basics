import UIKit

// https://leetcode.com/problems/largest-number/

class Solution {
    func largestNumber(_ nums: [Int]) -> String {
        let a = nums.map { String($0) }
        let b = a.sorted{ $0 > $1 }.sorted { Int($0 + $1)! > Int($1 + $0)! }
        
        return b.reduce("") { (result, str) -> String in
            if result == str && result == "0" {
                return result
            }
            return result + str
        }
    }
}

let s = Solution()
s.largestNumber([3,30,34,5,9])
