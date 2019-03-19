import UIKit

// O(nw) where n total item and
// w is the max length of each element
// Aux: Yes
// Inplace: No
// Stable: Yes. maintain the relative order of records with equal keys (i.e. values)

func countingSort(_ array: inout [Int], _ n: Int, _ exp: Int) {
    var output = Array(repeating: 0, count: n)
    var count  = Array(repeating: 0, count: 10)
    
    // Update count base on LSD
    array.forEach { x in
        let lsd = (x / exp) % 10
        count[lsd] += 1
    }
    
    // Compute running count. At anytime
    // count[i] will indicate how many items
    // with LSD of i incuding
    for i in 1..<10 {
        count[i] += count[i - 1]
    }
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        let lsd = ((array[i] / exp) % 10)
        
        // itemToBePlaced
        let itemToBePlaced = array[i]

        // item index
        let index = count[lsd] - 1
        
        // place the item to output
        output[index] = itemToBePlaced
        
        // decrease the counter as one item placed
        count[lsd] -= 1
    }
    array = output
}

func radixSort(_ array: inout [Int]) {
    guard !array.isEmpty, let max = array.max() else {
        return
    }
    let n = array.count
    var exp = 1
    while max / exp > 0 {
        countingSort(&array, n, exp)
        exp *= 10
    }
}

var array = [170, 45, 75, 90, 802, 24, 2, 66]
radixSort(&array)
print(array)
