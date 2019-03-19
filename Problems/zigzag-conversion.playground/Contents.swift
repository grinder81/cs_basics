import UIKit

// https://leetcode.com/problems/zigzag-conversion/

class Solution {
    
    // Analysis:
    // We just need to solve it for one zig and then repeating will get all
    
    private func methodZig1(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else { return s }
        
        var output = Array(repeating: "", count: numRows)

        var i    = 0
        var step = 1
        
        for c in s {
            output[i] += String(c)
            if i == 0 {
                step = 1
            } else if i == numRows - 1 {
                step = -1
            }
            i += step
        }
        return output.reduce("") { $0 + $1 }
    }
    
    func convert(_ s: String, _ numRows: Int) -> String {
        return methodZig1(s, numRows)
    }
}


let s = Solution()
s.convert("PAYPALISHIRING", 4)
