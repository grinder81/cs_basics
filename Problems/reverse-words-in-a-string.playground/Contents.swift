import UIKit

// https://leetcode.com/problems/reverse-words-in-a-string/


class Solution {
    func reverseWords(_ s: String) -> String {
        let subStrings = s.split(separator: " ")
        let n = subStrings.count
        var reverse = ""
        subStrings.reversed().enumerated().forEach { (index, str) in
            reverse += str
            if index < n - 1 {
                reverse += " "
            }
        }
        return reverse
    }
}

let s = Solution()
s.reverseWords("    ")
