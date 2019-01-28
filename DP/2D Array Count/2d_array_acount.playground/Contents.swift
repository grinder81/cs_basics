import UIKit

// Write a program that's count how many ways you can go
// from the top-left to the bottom-right in a 2D array.

func numberOfWays(_ m: Int, _ n: Int) -> Int {
    if m == 1 || n == 1 { return 1 }
    return  numberOfWays(m - 1, n) +
            numberOfWays(m, n - 1)
}

numberOfWays(5, 5)

func numberOfWaysMemo(_ m: Int, _ n: Int, _ memo: inout [[Int]]) -> Int {
    if m == 1 || n == 1 { return 1 }
    if memo[m][n] > 0 { return memo[m][n] }
    let q = numberOfWaysMemo(m - 1, n, &memo) +
            numberOfWaysMemo(m, n - 1, &memo)
    memo[m][n] = q
    return q
}

var memo = Array(repeating: Array(repeating: 0, count: 6), count: 6)
numberOfWaysMemo(5, 5, &memo)

func numberOfWaysDP(_ m: Int, _ n: Int) -> Int {
    var table = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
    
    for i in 1...m {
        for j in 1...n {
            if i == 1 || j == 1 {
                table[i][j] = 1
            } else {
                table[i][j] = table[i - 1][j] + table[i][j - 1]
            }
        }
    }
    return table[m][n]
}

numberOfWaysDP(5, 5)
