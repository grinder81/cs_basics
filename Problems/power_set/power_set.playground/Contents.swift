import UIKit

func recursivePowerSet(_ set: [Int], _ index: Int, _ subset: String) {
    if index == set.count {
        print(subset)
        return
    }
    recursivePowerSet(set, index + 1, subset + "\(set[index])")
    recursivePowerSet(set, index + 1, subset)
}

recursivePowerSet([1, 2, 3], 0, "")


func powerSet(_ set: [Int]) {
    let n = set.count
    let powerSetSize = NSDecimalNumber(decimal: pow(2, n)).intValue
    
    // loop through 0 to 2^n
    for index in 0..<powerSetSize {
        var subset = "{"
        for i in 0..<n {
            // If the i th bit set in the current index then chose it
            if (index & (1<<i)) > 0 {
                subset += "\(set[i])"
            }
        }
        subset += "}"
        print(subset)
    }
}

powerSet([1, 2, 3])

/**
 Output:
 
 {}
 {1}
 {2}
 {12}
 {3}
 {13}
 {23}
 {123}

 
 */

