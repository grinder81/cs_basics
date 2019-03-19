import UIKit

// https://leetcode.com/problems/minimum-window-substring/

class Solution {
    // Is that only capital letters?
    // Does it mean all the unique characters of T or reperative need to be counted as well?
    
    private func methodBF(_ s: String, _ t: String) -> String {
        let S = Array(s)
        let T = Array(t)

        let n = S.count
        let m = T.count

        var l = 0
        var r = 0
        var w = Int.max
        var lMin = 0
        var count = 0
        
        var map: [Character: Int] = [:]
        for c in t {
            if let v = map[c] {
                map[c] = v + 1
            } else {
                map[c] = 1
            }
        }
        
        // Keep r moving until:
        //  1. We find a window which contain all t
        //  2. Or we are done on looking
        while r < n {
            
            // If we find a match then go for it
            if let v = map[S[r]] {
                map[S[r]] = v - 1
                
                // If we find a valid case which is
                // still need looking for more from t
                if let x = map[S[r]], x >= 0 {
                    count += 1
                }
                
                // Now we found a match. let's try to minimize it
                // Move l to right to trim prefix extra character
                while count == m {
                    // Find a better length
                    if (r - l) < w {
                        lMin = l
                        w = min(w, r - l)
                    }
                    // While we were moving from l to r
                    // and we found a match then we mark
                    // reverse it again
                    if let v = map[S[l]] {
                        map[S[l]] = v + 1
                        if let x = map[S[l]], x > 0 {
                            count -= 1
                        }
                    }
                    l += 1
                }
            }
            r += 1
        }
        return w == Int.max ? "" : String(S[lMin...(lMin + w)])
    }
    
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty else { return "" }
        return methodBF(s, t)
    }
}

let s = Solution()
s.minWindow("ABDDCDDDBA", "ABC")
