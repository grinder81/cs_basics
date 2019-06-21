import UIKit

// https://leetcode.com/problems/valid-parentheses/

class Solution {
    func isValid(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        let array = Array(s)
        let n = array.count
        
        let open:  [Character] = ["(", "{", "["]
        let close: [Character] = [")", "}", "]"]
        
        var stack: [Character] = []
        
        var i = 0
        while i < n {
            let c = array[i]
            if stack.isEmpty || open.contains(c) {
                stack.append(c)
            } else {
                // We have a close bracket now
                let index = close.firstIndex(of: c)!
                let top = stack.removeLast()
                if top != open[index] {
                    return false
                }
            }
            i += 1
        }
        return stack.isEmpty
    }
    
    func trap(_ height: [Int]) -> Int {
        guard !height.isEmpty else { return 0 }
        
        let n = height.count
        
        var l = 0
        var r = n - 1
        
        // if a[l] < a[r]
        // a[l] > left max
        //  then no water is trapping for it so update left max
        //  otherwise add the area to total
        // do the same for right max
        
        var lMax = 0
        var rMax = 0
        
        var area = 0
        
        while l < r {
            //print("\(l) \(r)")
            if height[l] < height[r] {
                print("L \(l)")

                if height[l] >= lMax {
                    lMax = height[l]
                } else {
                    area += (lMax - height[l])
                }
                l += 1
            } else {
                print("R \(r)")

                if height[r] >= rMax {
                    rMax = height[r]
                } else {
                    area += (rMax - height[r])
                }
                r -= 1
            }
        }
        return area
    }
    
}

let s = Solution()
s.isValid("")
s.isValid("(((((")
s.isValid("}}}}}")
s.isValid("()[]{}")
s.trap([0,1,0,2,1,0,1,3,2,1,2,1])
