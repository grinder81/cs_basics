import UIKit

// Given weights and values of n items,
// put these items in a knapsack of capacity
// W to get the maximum total value in the knapsack.

// Analysis
// There are 2 choice on each step
// 1. Include the item
//      a. Consider the value
//      b. Subtract the item weight as we are considering
// 2. Don't include the item
//      a. Nothing change except going for next item


// Time: O(2^n)
// Space: O(n)
func knapsack(_ w: Int, _ wt: [Int], _ v: [Int], _ n: Int) -> Int {
    if w == 0 { return 0 }
    if n == 0 { return 0 }
    
    if wt[n - 1] > w {
        return knapsack(w, wt, v, n - 1)
    }
    // Include item
    let included    = v[n - 1] + knapsack(w - wt[n - 1], wt, v, n - 1)
    
    // Don't include item
    let notIncluded = knapsack(w, wt, v, n - 1)
    return max(included, notIncluded)
}

knapsack(50, [10, 20, 30], [60, 100, 120], 3)

// Memoization
// [weight][item] that's what we want to memoize

// Time: O(n * w)
// Space: O(n * w + n)
func knapsackMemo(_ w: Int, _ wt: [Int], _ v: [Int], _ n: Int, _ memo: inout Dictionary<String, Int>) -> Int {
    if w == 0 { return 0 }
    if n == 0 { return 0 }
    
    // Useing Hash we can following way
    // Or we can do by table like
    // dp[itemIndex][capacity] -> dp[np - 1][w]
    
    let key = "\(w)-\(n)"
    if let value = memo[key] {
        return value
    }
    
    if wt[n - 1] > w {
        return knapsackMemo(w, wt, v, n - 1, &memo)
    }
    // Include item
    let included    = v[n - 1] + knapsack(w - wt[n - 1], wt, v, n - 1)
    
    // Don't include item
    let notIncluded = knapsack(w, wt, v, n - 1)
    let q = max(included, notIncluded)
    memo[key] = q
    return q
 }

var memo: Dictionary<String, Int> = [:]
knapsackMemo(50, [10, 20, 30], [60, 100, 120], 3, &memo)

// Time: O(n * w)
// Space: O(n * w)
func knapsackDP(_ W: Int, _ wt: [Int], _ v: [Int]) -> Int {
    let n = wt.count
    var table = Array(repeating: Array(repeating: 0, count: W + 1), count: n + 1)
    
    for index in 0...n {
        for w in 0...W {
            if index == 0 || w == 0 {
                table[index][w] = 0
            } else if wt[index - 1] > w {
                table[index][w] = table[index - 1][w]
            } else {
                table[index][w] = max(v[index - 1] + table[index - 1][w - wt[index - 1]], table[index - 1][w])
            }
        }
    }
    return table[n][W]
}

knapsackDP(50, [10, 20, 30], [60, 100, 120])
