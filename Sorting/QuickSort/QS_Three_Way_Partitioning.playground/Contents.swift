import Foundation

// Time: O(nlogn)
// Inplace sort: Yes
// Stable sort: No
// Comparision sort: Yes
// Some facts: Any comparison sort can have avg O(n lg n) at best
// due to the fact that comparison tree is a binary tree with height
// of 2^h where is h is the height

func partition(_ array: inout[Int], p: Int, r: Int) -> (Int, Int) {
    var low     = p
    var high    = r
    var mid     = p
    
    // Pivot element
    let x = array[r]
    
    // There are 5 regions maintained by this partition system
    // array[p..low-1]      = less than pivot
    // array[low..mid-1]    = equal to pivot
    // array[mid..high-1]   = greater than pivot
    // array[high..r-1]     = all values unrestricted
    // array[r]             = pivot element
    
    while mid <= high {
        if array[mid] < x {
            array.swapAt(low, mid)
            low += 1
            mid += 1
        } else if array[mid] == x {
            mid += 1
        } else {
            array.swapAt(mid, high)
            high -= 1
        }
    }
    // Array partitioned in 2 parts:
    // lower part: p..low-1
    // upper part: high..r
    return (low-1, high)
}

func quickSort(_ array: inout[Int], p: Int, r: Int) {
    if p < r {
        // Randomize pivot
        let pi = Int.random(in: p..<r)
        array.swapAt(r, pi)
        let q = partition(&array, p: p, r: r)
        quickSort(&array, p: p, r: q.0)
        quickSort(&array, p: q.1, r: r)
    }
}

var array = [1, 1, 1, 1, 1, 1, 1]
quickSort(&array, p: 0, r: array.count - 1)

print(array)
