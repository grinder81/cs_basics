import UIKit

// You are climbing stairs. You can advance 1 to k steps at a time.
// Your destination is exactly n steps up.
// Write a program which takes as inputs n and k and
// returns the number of ways in which you can get to your destination.

// Analysis
// F(n, k) is the function that calculate.
// For n == 0, = 1
// For n == 1, = 1
// Then Sum{ F(n - 1, k) + F(n - 2, k) + .... + F(1, k) + F(0, k)}

func climbingStaris(_ n: Int, _ k: Int) -> Int {
    if n <= 1 { return 1 }
    var sum = 0
    for i in 1...k {
        sum += climbingStaris(n - i, k)
    }
    return sum
}

climbingStaris(4, 2)

func climbingStairsMemo(_ n: Int, _ k: Int, _ memo: inout [Int]) -> Int {
    if n <= 1 { return 1 }
    if memo[n] > 0 { return memo[n] }
    var sum = 0
    for i in 1...k {
        sum += climbingStairsMemo(n - i, k, &memo)
    }
    memo[n] = sum
    return sum
}

var memo = Array(repeating: 0, count: 5)
climbingStairsMemo(4, 2, &memo)

// O(kn)
func climbingStairsDP(_ n: Int, _ k: Int) -> Int {
    var table = Array(repeating: 0, count: n + 1)
    
    table[0] = 1
    table[1] = 1
    
    for i in 2...n {
        for j in 1...k {
            if i - j <= 1 {
                table[i] += 1
            } else {
                table[i] += table[i - j]
            }
        }
    }
    
    return table[n]
}
climbingStairsDP(4, 2)
