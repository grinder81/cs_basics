import UIKit

/*
 The question was as follows:
 
 [ [a],
 [b,  c],
 [d,  e, f] ,
 [g,  h,  i,  j ] ]
 
 The above is a tree-like data structure, you need to find the path with the maximum sum and print the output as a string.
 
 Example:
 Some Paths are:  {a , b, d, g}, {a, b, d, h} {a, c, e, h}
 Sum are: (a+b+d+g) = S1, (a+b+d+h)= S2, (a+c+e+h)= S3
 If  S1 is the maxSum, the output= LLL, if S3 is the maxSum, then output=RLL
 Here, b is the left of a, c is the right of a, e is the left of c and so on.
 */

class Solution {
    
    func findPath(_ matrix: [[Int]]) -> String {
        let n = matrix.count
        
        var cost = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        cost[0][0] = matrix[0][0]
        for r in 0..<(n - 1) {
            for c in 0...r {
                cost[r + 1][c]      = max(cost[r + 1][c],     cost[r][c] + matrix[r + 1][c])
                cost[r + 1][c + 1]  = max(cost[r + 1][c + 1], cost[r][c] + matrix[r + 1][c + 1])
            }
        }
        
        var mC = 0
        var maxV = Int.min
        for c in 0..<n {
            if cost[n - 1][c] > maxV {
                maxV = cost[n - 1][c]
                mC = c
            }
        }
        
        var r = n - 1
        var c = mC
        var cValue = maxV
        var path = ""
        
        while r != 0 {
            let r1 = r - 1
            let c1 = c
            let c2 = c - 1

            if (r1 >= 0 && c2 >= 0), cost[r1][c2] == cValue - matrix[r][c] {
                r = r1
                c = c2
                cValue = cost[r1][c2]
                path += "L"
            } else {
                r = r1
                c = c1
                cValue = cost[r1][c1]
                path += "R"
            }
        }
        print(cost)
        return String(path.reversed())
    }
}

let s = Solution()
let m = [[1], [2, 3], [100, 0, 0], [7, 8, 9, 10]]
s.findPath(m)
