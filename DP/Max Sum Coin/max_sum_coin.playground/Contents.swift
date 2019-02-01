import UIKit

// There are n coins in a line. Two players take turns to take a coin from one of the ends of the line until there are no more coins left. The player with the larger amount of money wins. Assume that you go first, describe an algorithm to compute the maximum amount of money you can win.

// Analysis
// If we have an array c[] which indicate all the coins
// c[0],c[1].....c[i],c[i+1]......c[j-1],c[j].....c[n]
// There are two options here:
// 1. You chose c[i]
//  a. Then opponent chose c[i+1] or c[j]
//      i. Opponent chose c[i+1] then Your rest of the option c[i+2]..c[j]
//      ii. Opponent chose c[j] then your rest of the option c[i+1]..c[j-1]
//  b. Opponenet is same claver like you so, you be left for MINIMUM from your
//      options which mean min{ MV(i+2, j), MV(i+1, j-1)}
//  c. C1 = c[i] + min{ MV(i+2, j), MV(i+1, j-1)}
// 2. You chose c[j]
//  a. Then opponent has options of c[i] or c[j-1]
//      i. Opponenet chose c[i] then rest of the coins c[i+1]..c[j-1]
//      ii.Opponenet chose c[j-1] then rest of the coins c[i]..c[j-2]
//  b. Again opponent is smart so your option is
//      min{ MV(i+1, j-1), MV(i, j-2)}
//  c. C2 = c[j] + min{ MV(i+1, j-1), MV(i, j-2)}
// 2. C = max{ C1, C2}

func optimalStrategyOfGame(_ c: [Int], _ i: Int, _ j: Int) -> Int {
    if i == j { return c[i] }
    if j == i + 1 { return max(c[i], c[j]) }
    let c1 = c[i] + min(optimalStrategyOfGame(c, i + 2, j), optimalStrategyOfGame(c, i + 1, j - 1))
    let c2 = c[j] + min(optimalStrategyOfGame(c, i + 1, j - 1), optimalStrategyOfGame(c, i, j - 2))
    return max(c1, c2)
}

optimalStrategyOfGame([8, 15, 3, 7, 6, 1], 0, 5)

func optimalStrategyOfGameMemo(_ c: [Int], _ memo: inout Dictionary<String, Int>, _ i: Int, _ j: Int) -> Int {
    if i == j { return c[i] }
    if j == i + 1 { return max(c[i], c[j]) }
    let key = "\(i)-\(j)"
    if let value = memo[key] { return value }
    let c1 = c[i] + min(optimalStrategyOfGameMemo(c, &memo, i + 2, j), optimalStrategyOfGameMemo(c, &memo, i + 1, j - 1))
    let c2 = c[j] + min(optimalStrategyOfGameMemo(c, &memo, i + 1, j - 1), optimalStrategyOfGameMemo(c, &memo, i, j - 2))
    let cMax = max(c1, c2)
    memo[key] = cMax
    return cMax
}

var memo: Dictionary<String, Int> = [:]
optimalStrategyOfGameMemo([8, 15, 3, 7, 6, 1], &memo, 0, 5)

func optimalStrategyOfGameDP( _ c: [Int]) -> Int {
    let n = c.count
    var table = Array(repeating: Array(repeating: 0, count: n), count: n)
    
    // Looks like the DP implementation is bit different
    // need to understand 
    
    
    return table[0][n - 1]
}

optimalStrategyOfGameDP([8, 15, 3, 7, 6, 1])
