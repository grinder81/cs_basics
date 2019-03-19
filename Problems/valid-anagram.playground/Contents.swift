import UIKit

// https://leetcode.com/problems/valid-anagram/

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        let a = Array(s)
        let b = Array(t)

        return a.sorted() == b.sorted()
    }
}
