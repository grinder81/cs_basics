import UIKit

// Give n size rod, size[] and coresponding p[] of each size.
// Find the maximum profite we can get by different size cut on n


// Analysis
// We can cut the rod n = r1 + r2 + .... + rk where 1<= k <= n
// and profit should be maximum whatever combination we chose
// We can generate super set of size[] for n and that will be 2^n
// which is exponential. We can write code for that like this:

// max(q, p[i] + rn-1)

func cuttinRod(_ n: Int, _ p: [Int]) -> Int {
    if n == 0 { return 0 }
    var q = Int.min
    for i in stride(from: 0, to: n, by: 1) {
        q = max(q, p[i] + cuttinRod(n - (i + 1), p))
    }
    return q
}

let r1 = cuttinRod(5, [1, 10, 12, 15, 16])


// Top-Down approach
func cuttingRodMemoization(_ n: Int, _ p: [Int], _ r: inout[Int]) -> Int {
    // Base case
    if n == 0 { return 0 }
    
    // Use it from cache
    if r[n] >= 0 { return r[n] }
    
    var q = Int.min
    for i in stride(from: 0, to: n, by: 1) {
        q = max(q, p[i] + cuttingRodMemoization(n - (i + 1), p, &r))
    }
    
    r[n] = q
    return q
}

var rev = Array<Int>(repeating: Int.min, count: 6)
let r2 = cuttingRodMemoization(5, [1, 10, 12, 15, 16], &rev)

// Bottom-up approach
func cuttingRoadBottomUp(_ n: Int, _ p: [Int]) -> Int {
    var r = Array<Int>(repeating: Int.min, count: n + 1)
    r[0] = 0
    for j in stride(from: 1, through: n, by: 1) {
        var q = Int.min
        for i in stride(from: 1, through: j, by: 1) {
            q = max(q, p[i - 1] + r[j - i])
        }
        r[j] = q
    }
    return r[n]
}

let r3 = cuttingRoadBottomUp(5, [1, 10, 12, 15, 16])
