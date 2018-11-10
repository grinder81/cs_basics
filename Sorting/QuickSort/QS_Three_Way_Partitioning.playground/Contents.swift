import Foundation

func partition(_ array: inout[Int], p: Int, r: Int) -> (Int, Int) {
    var low     = p
    var high    = r
    var mid     = p
    
    // Pivot element
    let x = array[r]
    
    // There are 5 regions maintained by this partition system
    // array[p..low-1]      = less than pivot
    // array[low..mid-1]    = equal to pivot
    // array[mid..high]     = greater than pivot
    // array[high+1..r-1]   = all values unrestricted
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
    
    return (low-1, mid)
}

func quickSort(_ array: inout[Int], p: Int, r: Int) {
    if p < r {
        let q = partition(&array, p: p, r: r)
        quickSort(&array, p: p, r: q.0)
        quickSort(&array, p: q.1, r: r)
    }
}

var array = [11, 2, 3, 104]
quickSort(&array, p: 0, r: array.count - 1)

print(array)
