import Foundation

// Important fact:
//  - This is linear sort
//  - O(k+n) where
//      - k >= 0
//      - any elements in the array < k
//  - There is no comparison!
// Stable: Yes.
// Inplace: No
// Aux space: Yes
// It's ONYLY applicable if data range is limited
// Like: 0 to 1000

func countingSort(_ array: [Int], output: inout[Int], k: Int) {
    var c = Array(repeating: 0, count: k)
    // Count how many times each element has
    for item in array {
        c[item] = c[item] + 1
    }
    // Index's running sum. That's indicate at
    // c[index] how many elements has at input array
    // which is <= index
    for index in 1..<k {
        c[index] = c[index] + c[index - 1]
    }
    
    for index in stride(from: array.count - 1, through: 0, by: -1) {
        // Indicate which element is about
        // to place in correct place
        let itemToBePlaced = array[index]
        
        // Find the final index from sum Index
        let itemIndex = c[itemToBePlaced] - 1

        // Place the item in proper index
        output[itemIndex] = itemToBePlaced
        
        // We placed one item reduce the counter
        c[itemToBePlaced] = c[itemToBePlaced] - 1
    }
}

var array = [1, 0, 0, 2, 1, 9]
var output = Array(repeating: 0, count: array.count)
countingSort(array, output: &output, k: 10)
print(output)



