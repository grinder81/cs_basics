import UIKit

// https://leetcode.com/problems/rotate-image/

// Transpose the matrix which is matrix[i][j] -> matrix[j][i]
// Then flip horizontally matrix[i][j] -> matrix[i][n - 1 - j]

class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        
        for i in 0..<n {
            for j in (i + 1)..<n {
                let t = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = t
            }
        }
        
        for i in 0..<n {
            for j in 0..<n/2 {
                let t = matrix[i][j]
                matrix[i][j] = matrix[i][n - 1 - j]
                matrix[i][n - 1 - j] = t
            }
        }
        
    }
}
var m = [[1,2,3],[4,5,6],[7,8,9]]
let s = Solution()
s.rotate(&m)
print(m)
