import UIKit

// Given two strings str1 and str2 and below operations that can performed on str1.
// Find minimum number of edits (operations) required to convert ‘str1’ into ‘str2’.

// Analysis
// We can 3 operation on the source string
// 1. Insert
// 2. Delete
// 3. Replace

// O(3^m)
func editDistance(_ str1: [Character], _ str2: [Character], _ m: Int, _ n: Int) -> Int {
    if m == 0 { return n }
    if n == 0 { return m }
    
    if str1[m - 1] == str2[n - 1] {
        return editDistance(str1, str2, m - 1, n - 1)
    }
    // Insert
    // We keep source index same but reduce the desitination index
    // which mean if doing we got a match then that's a successful operation
    let i = editDistance(str1, str2, m, n - 1)
    
    // Delete
    let d = editDistance(str1, str2, m - 1, n)
    
    // Replace
    let r = editDistance(str1, str2, m - 1, n - 1)
    
    return 1 + min(min(i, d), r)
}

editDistance(Array("Hello"), Array("Ola"), 5, 3)

func editDistanceMemo(_ str1: [Character], _ str2: [Character], _ m: Int, _ n: Int, _ memo: inout [[Int]]) -> Int {
    if m == 0 { return n }
    if n == 0 { return m }
    
    if memo[m - 1][n - 1] != Int.max {
        return memo[m - 1][n - 1]
    }
    
    if str1[m - 1] == str2[n - 1] {
        return editDistanceMemo(str1, str2, m - 1, n - 1, &memo)
    }
    
    let i = editDistanceMemo(str1, str2, m, n - 1, &memo)
    let d = editDistanceMemo(str1, str2, m - 1, n, &memo)
    let r = editDistanceMemo(str1, str2, m - 1, n - 1, &memo)
    memo[m - 1][n - 1] = 1 + min(min(i, d), r)
    return memo[m - 1][n - 1]
}

var memo = Array(repeating: Array(repeating: Int.max, count: 3), count: 5)
editDistanceMemo(Array("Hello"), Array("Ola"), 5, 3, &memo)

func editDistanceDP(_ str1: [Character], _ str2: [Character]) -> Int {
    let m = str1.count
    let n = str2.count
    
    var table = Array(repeating: Array(repeating: Int.max, count: n + 1), count: m + 1)
    
    for i in 0...m {
        for j in 0...n {
            if i == 0 {
                table[i][j] = j
            } else if j == 0 {
                table[i][j] = i
            } else if str1[i - 1] == str2[j - 1] {
                table[i][j] = table[i - 1][j - 1]
            } else {
                table[i][j] = 1 + min(min(table[i][j - 1], table[i - 1][j]), table[i - 1][j - 1])
            }
        }
    }
    return table[m][n]
}

editDistanceDP(Array("Hello"), Array("Ola"))
