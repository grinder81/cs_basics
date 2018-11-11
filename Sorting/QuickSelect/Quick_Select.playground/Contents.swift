import Foundation

// Quick select is a selection algorithm to find the k-th smallest element in an unordered list.
// Input: [7, 10, 4, 3, 20, 15]
// k = 3
// Output: 7

func partition(_ array: inout[Int], p: Int, r: Int) -> Int {
    var low  = p - 1

    // Pivot element
    var x = array[r]
    
    for high in p...r-1 {
        if array[high] <= x {
            low += 1
            array.swapAt(low, high)
        }
    }
    array.swapAt(low + 1, r)
    return low + 1
}

func quickSelect(_ array: inout[Int], p: Int, r: Int, k: Int) -> Int {
    // In case of out bound k index
    if k > array.count {
        return Int.max
    }
    // if only one element
    if p == r {
        return array[p]
    }
    
    let q = partition(&array, p: p, r: r)
    if q == k - 1 {
        return array[q]
    } else if q < k {
        return quickSelect(&array, p: q + 1, r: r, k: k)
    } else {
        return quickSelect(&array, p: p, r: q - 1, k: k)
    }
}

var array = [7, 10, 4, 3, 20, 15]
let item = quickSelect(&array, p: 0, r: array.count - 1, k: 3)
print(item)
