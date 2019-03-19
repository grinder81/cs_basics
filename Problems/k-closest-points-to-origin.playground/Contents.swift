import UIKit

// https://leetcode.com/problems/k-closest-points-to-origin/

class Solution {
    
    private func sqrDistance(_ x: [Int]) -> Int {
        return x[0] * x[0] + x[1] * x[1]
    }
    
    private func pivoting(_ points: inout [[Int]], _ p: Int, _ r: Int) -> Int {
        var low = p - 1
        let x = points[r]
        
        for high in p...(r - 1) {
            if sqrDistance(points[high]) <= sqrDistance(x) {
                low += 1
                points.swapAt(low, high)
            }
        }
        points.swapAt(low + 1, r)
        return low + 1
    }
    
    private func quickSelect(_ points: inout [[Int]], _ l: Int, _ r: Int, _ K: Int) {
        if l >= r { return }
        
        let k = Int.random(in: l...(r - 1))
        points.swapAt(k, r)
        
        let q = pivoting(&points, l, r)
        
        // This is the left length of sorted array
        let length = q - l + 1
        
        // If left length is less then we need more element from
        // upper part of the array
        if length < K {
            // Missed the `length` subtruction
            // We already have length number of element
            // so we just need K - length
            quickSelect(&points, q + 1, r, K - length)
        } else if length > K {
            quickSelect(&points, l, q - 1, K)
        }
    }
    
    private func methodQS(_ points: [[Int]], _ K: Int) -> [[Int]] {
        var array = Array(points)
        quickSelect(&array, 0, array.count - 1, K)
        return Array(array[0...K-1])
    }
    
    // O(nlogn)
    private func methodSimple(_ points: [[Int]], _ K: Int) -> [[Int]] {
        let p = points.enumerated()
            .map{ ($0, ($1[0] * $1[0] + $1[1] * $1[1])) }
            .sorted{ $0.1 < $1.1 }
        
        var k = 0
        var result: [[Int]] = []
        while k < K {
            result.append(points[p[k].0])
            k += 1
        }
        
        return result
    }
    
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        let n = points.count
        guard !points.isEmpty, n >= K else { return [] }
        
        //return methodSimple(points, K)
        return methodQS(points, K)
    }
}
