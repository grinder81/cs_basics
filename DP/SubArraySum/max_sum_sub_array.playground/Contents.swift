import UIKit

// Find maximum subarray in a given array of integers.

// Analysis. let's find how many subarray we can find from an array
// [1] = [1] = 1
// [1, 2] = [1], [2], [1, 2] = 3
// [1, 2, 3] = [1], [2], [3], [1, 2], [2, 3], [1, 2, 3] = 6

// First step should be how we can generate all these sub array
// O(n^2) to generate it and then do the sum

func maxSubArray1(_ array: [Int]) -> Int {
    let n = array.count
    var q = Int.min
    for i in stride(from: 0, to: n, by: 1) {
        for j in stride(from: 0, through: i, by: 1) {
            var sum = 0
            for k in stride(from: j, through: i, by: 1) {
                sum += array[k]
            }
            q = max(q, sum)
        }
    }
    return q
}

maxSubArray1([1, -2, 3, 2, -1, 100])

func maxSubArray2(_ p: [Int]) -> Int {
    let n = p.count
    var maxSum = Int.min
    for i in 0..<(n - 1) {
        var sum = 0
        for j in i..<n {
            sum += p[j]
            maxSum = max(maxSum, sum)
        }
    }
    return maxSum
}

maxSubArray2([1, -2, 3, 2, -1, 100])

// [1]
// [1, 2]
// [2]
// [1, 2, 3]
// [2, 3]
// [3]

// But we can use divide and conquer
// n/2 and [0..m] and [m+1..n-1] are 2 division
// we can have max in either folloing cases
// a. Max sum in L [0..m]
// b. Max sum in R [m+1..n-1]
// c. Max sum is L + R in this case [0..n-1]

func maxSubArrayDnCInternal(_ array: [Int], _ l: Int, _ r: Int) -> Int {
    if l == r { return array[l] }
    let m = (l + r) / 2
    let lrMax = max(maxSubArrayDnCInternal(array, l, m),
                    maxSubArrayDnCInternal(array, m + 1, r))
    return max(lrMax, maxCalculation(array, l, m, r))
}

func maxCalculation(_ array: [Int], _ l: Int, _ m: Int, _ r: Int) -> Int {
    var sum = 0
    var lSum = Int.min
    
    for i in stride(from: m, through: l, by: -1) {
        sum += array[i]
        if sum > lSum {
            lSum = sum
        }
    }

    sum = 0
    var rSum = Int.min
    for i in stride(from: m + 1, through: r, by: 1) {
        sum += array[i]
        if sum > rSum {
            rSum = sum
        }
    }
    return lSum + rSum
}


func maxSubArrayDnC(_ array: [Int]) -> Int {
    return maxSubArrayDnCInternal(array, 0, array.count - 1)
}

maxSubArrayDnC([1, -2, 3, 2, -1, 100])

func maxSubArrayDP(_ array: [Int]) -> Int {
    let n = array.count
    var cache = Array<Int>(repeating: 0, count: n)
    cache[0] = array[0]
    for i in stride(from: 1, to: n, by: 1) {
        cache[i] = max(array[i], array[i] + cache[i - 1])
    }
    
    var q = array[0]
    for i in stride(from: 1, to: n, by: 1) {
        let m = max(array[i], array[i] + cache[i - 1])
        q = max(q, m)
    }
    return q
}

maxSubArrayDP([1, -2, 3, 2, -1, 100])
