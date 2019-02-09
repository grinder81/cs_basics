import UIKit

// Consider the problem of neatly printing a paragraph with a monospaced font
// (all characters having the same width) on a printer.
// The input text is a sequence of nn words of lengths [l1, l2, ... ln]
// measured in characters. We want to print this paragraph neatly on a
// number of lines that hold a maximum of M characters each.
// We wish to minimize the sum, over all lines except the last,
// of the cubes of the numbers of extra space characters at the ends of lines.


// Analysis
// We will have:
//  1. l[] which indicate length of each words
//  2. m whihc is the length of each line or width of line
//  3. Between each word one space allowed
//  4. End the line space indicate the messiness
// Let's consider we want to fit i to j (i <= j) in a line then following is true for it:
//  1. Extra[i, j] = m - (j - i) - sum{li, l(i+1) ...lj} where (i<=k<=j)
//      a. This extra[i, j] is the space at end of the line where i to j word placed at this line
//  2. We define lc[i][j] where it indicate line cost to include i to j words at this line
//  3. We can define a recursive function for it in following way:
//      a. lc[i][j] = INF   if extra[i][j] < 0 which mean word i to j doesn't fit
//      b. lc[i][j] = 0     if j == n &&  extra[i][j] >= 0 which mean last line
//      c. lc[i][j] = extra[i][j]^2 or extra[i][j]^3 which mean i to j words included
//  4. We want to minimize sum of lc for overal all lines
//  5. Subproblems is: how to optimally arrange 1...j where j = 1...n
//  6. The optimal solution will only come if 1...(i-1) is also placed optiamally
//  7. Let c[j] is the cost of arranging word optimally from 1...j
//      a. If we know last line contain word i to j then cost[j] = cost[i - 1] + lc[i][j]
//      b. Our base case c[0] = 0 and c[1] = lc[1][1]
//  8. Recursion:
//      a. M(j) = 0 if j == 0
//      b. M(j) = min{ f(i, j) } + M(j - 1)
//
//      a. c[j] = 0 if j = 0
//      b. c[j] = min{ c[i - 1] + lc[i][j] } where 1 <=i<=j if j > 0

func prettyPrintDP(_ l: [Int], _ n: Int, _ m: Int) {
    var p   = Array(repeating: 0, count: n + 1)
    var c   = Array(repeating: 0, count: n + 1)
    var lc  = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
    var extras = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
    
    for i in 1...n {
        // Only including current word
        extras[i][i] = m - l[i - 1]
        
        var j = i + 1
        while j <= n {
            // There could be 2 case:
            //  a. < 0 which mean word from i to j can't fit in a line
            //  b. >= 0 which mean i to j fit in a line with some extra or no space at the end
            //  '-1' at the end to subtract the 1 space in between word
            extras[i][j] = extras[i][j - 1] - l[j - 1] - 1
            j += 1
        }
    }
    for i in 1...n  {
        for j in i...n {
            // < 0 mean can't fit word from i to j
            if extras[i][j] < 0 {
                lc[i][j] = Int.max
            }
            // you are in last line or perfectly fit i to j
            else if j == n && extras[i][j] >= 0 {
                lc[i][j] = 0
            }
            // we have some cost to fit i to j
            else {
                lc[i][j] = extras[i][j] * extras[i][j]
            }
        }
    }
    
    c[0] = 0
    for j in 1...n {
        c[j] = Int.max
        for i in 1...j {
            // We need to chose that:
            //  Cost of arranging 1 to j-1 + cost of messiness for i to j is min
            if (c[j - 1] != Int.max && lc[i][j] != Int.max) &&
                (c[j - 1] + lc[i][j] < c[j]) {
                c[j] = c[j - 1] + lc[i][j]
                // We can fit i to j in same line
                p[j] = i
                print("\(i) - \(j): \(c[j])")
            }
        }
    }
    printSolution(p, n)
}

func printSolution(_ p: [Int], _ j: Int) -> Int {
    var k = 0
    var i = p[j]
    if i == 1 {
        k = 1
    } else {
        k = 1 + printSolution(p, i - 1)
    }
    print("For line \(k): \(i) - \(j)")
    return k
}

prettyPrintDP([5, 5, 2, 2, 5], 5, 6)

//func prettyPrintRecursion(_ l: [Int], _ j: Int, _ m: Int) -> Int {
//    
//}
