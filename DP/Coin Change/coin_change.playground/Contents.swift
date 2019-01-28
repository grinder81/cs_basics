import UIKit

// Given a value N, if we want to make change for N cents,
// and we have infinite supply of each of S = { S1, S2, .. , Sm} valued coins,
// how many ways can we make the change? The order of coins doesn’t matter.

// Analysis
// 1. Count considering mth coin
// 2. Count without mth coin
// Sum of these 2 is the number of solution

func countCoin(_ a: [Int], _ m: Int, _ n: Int) -> Int {
    // We have a solution
    if n == 0 { return 1 }
    
    // no solution
    if n < 0 { return 0 }
    
    // we have no change but still value left
    if m == 0 && n > 0 { return 0 }
    
    return  countCoin(a, m - 1, n) +        // Don't include
            countCoin(a, m, n - a[m - 1])   // Include or use the coin
}

countCoin([1, 2, 3], 3, 5)

func countCoinMemoization(_ a: [Int], _ memo: inout Dictionary<String, Int>, _ m: Int, _ n: Int) -> Int {
    // We have a solution
    if n == 0 { return 1 }
    
    // no solution
    if n < 0 { return 0 }
    
    // we have no change but still value left
    if m == 0 && n > 0 { return 0 }
    
    let key = "\(n)-\(m)"
    if let value = memo[key] {
        return value
    }
    
    let q = countCoinMemoization(a, &memo, m - 1, n) +         // Don't use the coin
            countCoinMemoization(a, &memo, m, n - a[m - 1])    // Use the coin and subtract it
    memo[key] = q
    return q
}

var memo: Dictionary<String, Int> = [:]
countCoinMemoization([1, 2, 3], &memo, 3, 5)


func countCoinMemoizationWithArray(_ a: [Int], _ memo: inout [[Int]], _ index: Int, _ money: Int) -> Int {
    // We have a solution
    if money == 0 { return 1 }
    
    // no solution
    if money < 0 { return 0 }
    
    // we have no change but still value left
    if index == 0 && money > 0 { return 0 }
    
    if memo[money][index] > 0 {
        return memo[money][index]
    }
    
    let q = countCoinMemoizationWithArray(a, &memo, index - 1, money) +
            countCoinMemoizationWithArray(a, &memo, index, money - a[index - 1])
    memo[money][index] = q
    return q
}

var tableMemo = Array(repeating: Array<Int>(repeating: 0, count: 4), count: 6)
countCoinMemoizationWithArray([1, 2, 3], &tableMemo, 3, 5)

func countCoinTabulization(_ coins: [Int], _ money: Int) -> Int {
    let m = money
    let n = coins.count
    
    var table =  Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

    // Base case
    // For 0 money any coin change is valid and
    // count is 1
    for index in 0..<n {
        table[0][index] = 1
    }
    
    for mIndex in 1...m {
        for cIndex in 0..<n {
            // Don't include it
            let x = (cIndex >= 1) ? table[mIndex][cIndex - 1] : 0
            
            // Use coins[cIndex] which mean subtract it
            let y = (mIndex - coins[cIndex]) >= 0 ? table[mIndex - coins[cIndex]][cIndex] : 0
            table[mIndex][cIndex] = x + y
        }
    }
    return table[m][n - 1]
}

countCoinTabulization([1, 2, 3], 5)
