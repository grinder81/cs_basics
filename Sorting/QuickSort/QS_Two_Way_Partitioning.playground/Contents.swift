import Foundation

// Time: O(nlogn)
// Inplace sort: Yes
// Stable sort: No
// Comparision sort: Yes
// Some facts: Any comparison sort can have avg O(n lg n) at best
// due to the fact that comparison tree is a binary tree with height
// of 2^h where is h is the height

func twoWayPartition(_ array: inout[Int], p: Int, r: Int) -> Int {
    // Pivot element arround which to partition the subarray array[p..r]
    let x = array[r]
    
    // Expected pivot index
    var low = p - 1
    
    // There are 4 regions maintained by this partition system
    // array[p..low]        = all values less than or equal to x
    // array[low+1..high-1] = all values greater than x
    // array[high..r-1]     = all values unrestricted
    // array[r] == x        = the pivot element
    
    for high in p...r-1 {
        if array[high] <= x {
            low += 1
            array.swapAt(low, high)
        }
    }
    // Place the array[r] in a position where
    // everything left <= of it
    // everything right > of it
    array.swapAt(low + 1, r)
    
    // Divide the array from this index
    return low + 1
}
/**
 - parameter array: Array to be sorted
 - parameter p: lower index
 - parameter r: right index
 */
func quickSort(_ array: inout[Int], p: Int, r: Int) {
    // Safety net
    if r >= array.count { return }
    
    if p < r {
        // Randomize pivot
        let pi = Int.random(in: p..<r)
        array.swapAt(r, pi)
        // q is the partition index
        let q = twoWayPartition(&array, p: p, r: r)
        quickSort(&array, p: p, r: q - 1)
        quickSort(&array, p: q + 1, r: r)
    }
}

var array = [5, 0, -100, 1]
quickSort(&array, p: 0, r: array.count - 1)

print(array)
