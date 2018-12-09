import UIKit

// https://leetcode.com/problems/longest-substring-without-repeating-characters/

func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count == 0 { return 0 }
    var l = 0
    var r = 1
    let n = s.count
    let array = Array(s)
    
    var maxLen = -1
    var hash: Dictionary<Character, Int> = [:]
    
    hash[array[0]] = 0
    while r < n {
        if let index = hash[array[r]], index >= l {
            if (r - l) > maxLen {
                maxLen = r - l
            }
            l = index + 1
        }
        hash[array[r]] = r
        r += 1
    }
    if (r - l) > maxLen {
        maxLen = r - l
    }
    return maxLen
}

lengthOfLongestSubstring("abc")
lengthOfLongestSubstring("aaaa")
lengthOfLongestSubstring("dvdf")
lengthOfLongestSubstring("aaaaaaaabc")
lengthOfLongestSubstring("a")
