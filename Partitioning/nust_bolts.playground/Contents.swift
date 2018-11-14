import Foundation

/**
Given a set of n nuts of different sizes and n bolts of different sizes. There is a one-one mapping between nuts and bolts. Match nuts and bolts efficiently.
Constraint: Comparison of a nut to another nut or a bolt to another bolt is not allowed. It means nut can only be compared with bolt and bolt can only be compared with nut to see which one is bigger/smaller.

Other way of asking this problem is, given a box with locks and keys where one lock can be opened by one key in the box. We need to match the pair.
*/

func partition(_ array: inout[Int], p: Int, r: Int, x: Int) -> Int {
    var low = p - 1
    
    for high in p...r-1 {
        if array[high] < x {
            low += 1
            array.swapAt(low, high)
        }
    }
    array.swapAt(low + 1, r)
    return low + 1
}


func matchPair(_ nuts: inout[Int], bolts: inout[Int], p: Int, r: Int) {
    if nuts.count != bolts.count { return }
    if p < r {
        let q = partition(&nuts, p: p, r: r, x: nuts[r])
        
        partition(&bolts, p: p, r: r, x: bolts[r])
        
        matchPair(&nuts, bolts: &bolts, p: p, r: q - 1)
        matchPair(&nuts, bolts: &bolts, p: q + 1, r: r)
    }
}

var nuts = [3, 2, 1, 5, 6]
var bolts = [6, 5, 1, 2, 3]

matchPair(&nuts, bolts: &bolts, p: 0, r: nuts.count - 1)

print(nuts)
print(bolts)
