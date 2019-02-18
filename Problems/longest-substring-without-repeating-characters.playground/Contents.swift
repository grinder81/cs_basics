import UIKit

// https://leetcode.com/problems/longest-substring-without-repeating-characters/

// Attempt 1
// O(n^2)
class Solution1 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        
        let text = Array(s)
        let n = s.count
        
        var i = 0
        var maxW = 0
        while i < n {
            var j = i + 1
            var map: [Character: Bool] = [:]
            map[text[i]] = true
            while j < n, map[text[j]] == nil {
                map[text[j]] = true
                j += 1
            }
            maxW = max(maxW, j - i)
            i += 1
        }
        
        return maxW
    }
}


// Attempt 2
// O(n)
class Solution2 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else {
            return 0
        }
        
        let t = Array(s)
        let n = s.count
        
        var l = 0
        var r = 1
        // Made mistake here not consider
        // default is 1 because at this time
        // I have at least one character
        var w = 1
        
        var m: [Character: Int] = [:]
        m[t[l]] = 0
        while r < n {
            // Made a mistake by not considering
            // i >= l. That's a huge mistake not considering
            // when taking new expanding or shrinking window size
            if let i = m[t[r]], i >= l {
                // move to next index where there is no repeat
                l = i + 1
            }
            m[t[r]] = r
            w = max(w, r - l + 1)
            r += 1
        }
        
        return w
    }
}

let s = Solution2()
s.lengthOfLongestSubstring("abba")
s.lengthOfLongestSubstring("abc")
s.lengthOfLongestSubstring("aaaa")
s.lengthOfLongestSubstring("dvdf")
s.lengthOfLongestSubstring("aaaaaaaabc")
s.lengthOfLongestSubstring("a")
