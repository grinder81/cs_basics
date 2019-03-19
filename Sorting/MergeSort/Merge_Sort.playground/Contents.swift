import Foundation

// Comparision sort: Yes
// Stable: Yes. It doesn't swap equal elements
// Inplace: No
// Aux Space: Yes
// Time: Avg O(NlgN)
// Some facts: Any comparison sort can have avg O(n lg n) at best
// due to the fact that comparison tree is a binary tree with height
// of 2^h where is h is the height


func merge(_ array: inout[Int], low: Int, mid: Int, high: Int) {
    let aux = Array(array)
    var i = low
    var j = mid + 1
    var k = low
    while k <= high {
        // If lower part exhausted then keep copying
        // upper part rest of the elements
        if i > mid {
            array[k] = aux[j]
            j += 1
        }
        // if upper part exhausted then keep copying
        // lower part rest of the elements
        else if j > high {
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

func mergeSort(_ array: inout[Int], low: Int, high: Int) {
    if low < high {
        let mid = low + (high - low) / 2
        mergeSort(&array, low: low, high: mid)
        mergeSort(&array, low: mid + 1, high: high)
        merge(&array, low: low, mid: mid, high: high)
    }
}

var array = [3, 2, 1, 4, 5]
mergeSort(&array, low: 0, high: array.count - 1)
print(array)
