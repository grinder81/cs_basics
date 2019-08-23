// Sorting
//  1. Quick sort
//  2. Merge sort
// Searching
//  1. Binary search
//  2. Quick select
// String
// Array

func partition(_ array: inout[Int], _ l: Int, _ r: Int) -> Int {
    // that's the pivot item and we
    // are going to find proper place for it
    let x = array[r]
    var low = l - 1
    for high in l...r-1 {
        if array[high] <= x {
            low += 1
            array.swapAt(low, high)
        }
    }
    array.swapAt(low + 1, r)
    
    return low + 1
}

func threeWayPartition(_ array: inout[Int], _ l: Int, _ r: Int) -> (Int, Int) {
    var low = l
    var mid = l
    var high = r
    
    let x = array[r]
    
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
    
    return (low - 1, high)
}

func quickSort(_ array: inout[Int], _ l: Int, _ r: Int) {
    if (l < r) {
        // partition based on pivot item
        // Find pivot index
        // sort l to q - 1
        // sort q + 1 to r
        let q = partition(&array, l, r)
        quickSort(&array, l, q - 1)
        quickSort(&array, q + 1, r)
    }
}

var array = [5, 0, -100, 1]
quickSort(&array, 0, array.count - 1)

print(array)


func merge(_ array: inout[Int], _ l: Int, _ m: Int, _ r: Int) {
    let aux = Array(array)
    var i = l
    var j = m + 1
    var k = l
    
    while k <= r {
        // aux[i] < aux[j]
        //  array[k] = aux[i]
        //  i++
        // aux[i] >= aux[j]
        //  array[k] = aux[i=j]
        //  j++
        
        if i > m {
            array[k] = aux[j]
            j += 1
        } else if j > r {
            array[k] = aux[i]
            i += 1
        } else if aux[i] < aux[j] {
            array[k] = aux[i]
            i += 1
        } else {
            array[k] = aux[j]
            j += 1
        }
        k += 1
    }
}

func mergeSort(_ array: inout[Int], _ l: Int, _ r: Int) {
    if l < r {
        let m = l + (r - l) / 2
        mergeSort(&array, l, m)
        mergeSort(&array, m + 1, r)
        merge(&array, l, m, r)
    }
}

func quickSelect(_ array: inout[Int], _ l: Int, _ r: Int, _ k: Int) -> Int? {
    if k > array.count {
        return nil
    }
    
    if l == r {
        return array[l]
    }
    
    let q = partition(&array, l, r)
    if q == k - 1 {
        return array[q]
    } else if q < k {
        return quickSelect(&array, q + 1, r, k)
    } else {
        return quickSelect(&array, l, q - 1, k)
    }
}

func binarySearch(_ array: [Int], _ l: Int, _ r: Int, _ key: Int) -> Int? {
    if l > r {
        return nil
    }
    
    let m = l + (r - l) / 2
    if array[m] == key {
        return m
    } else if array[m] < key {
        return binarySearch(array, m + 1, r, key)
    } else {
        return binarySearch(array, l, m - 1, key)
    }
}

