import UIKit

class Solution {
    // Time: O(n^2)
    // Space: O(n^2)
    func method2(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        // a + b + c + d = 0
        // a + b = -c - d
        // a + b = -(c + d)
        let n = A.count
        var map: [Int: Int] = [:]
        
        for i in 0..<n {
            for j in 0..<n {
                let sum = A[i] + B[j]
                let v = map[sum] ?? 0
                map[sum] = v + 1
            }
        }
        
        var count = 0
        for i in 0..<n {
            for j in 0..<n {
                let sum = -1 * (C[i] + D[j])
                let v = map[sum] ?? 0
                count += v
            }
        }
        
        return count
    }
    
    // O(n^4)
    func method1(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var count = 0
        for a in A {
            for b in B {
                for c in C {
                    for d in D {
                        if a + b + c + d == 0 {
                            count += 1
                        }
                    }
                }
            }
        }
        
        return count
    }
    
    func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        return method2(A, B, C, D)
    }
}
