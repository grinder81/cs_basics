import UIKit

// https://leetcode.com/problems/group-anagrams/


class Solution {
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map: [Int: [String]] = [:]
        strs.forEach { (str) in
            let key = str.sorted().hashValue
            //map[key] = 1
        }
        let v = map.values
        print("\(map.keys) \(map.values)")
        var result: [[String]] = []
        map.values.forEach { (r) in
            result.append(r)
        }
        return result
    }
}

let s = Solution()
s.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
