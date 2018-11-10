import Foundation

func twoWayPartition(_ array: inout[Int], p: Int, r: Int) -> Int {
    // Pivot element arround which to partition the subarray array[p..r]
    let x = array[r]
    
    // Expected pivot index
    var i = p - 1
    
    // There are 4 regions maintained by this partition system
    // array[p..i]      -> all values less than or equal to x
    // array[i+1..j-1]  -> all values greater than x
    // array[j..r-1]    -> all values unrestricted
    // array[r] == x    -> the pivot element
    
    for j in p...r-1 {
        if array[j] <= x {
            i += 1
            array.swapAt(i, j)
        }
    }
    // Place the array[r] in a position where
    // everything left <= of it
    // everything right > of it
    array.swapAt(i + 1, r)
    
    // Divide the array from this index
    return i + 1
}
/**
 - parameter array: Array to be sorted
 - parameter p: partition index
 - parameter r: right index
 */
func quickSort(_ array: inout[Int], p: Int, r: Int) {
    // Safety net
    if r >= array.count { return }
    
    if p < r {
        let q = twoWayPartition(&array, p: p, r: r)
        quickSort(&array, p: p, r: q - 1)
        quickSort(&array, p: q + 1, r: r)
    }
}

var array = [5, 0, -100, 1]
quickSort(&array, p: 0, r: array.count - 1)

print(array)
