import Foundation

/**
Given a set of n nuts of different sizes and n bolts of different sizes. There is a one-one mapping between nuts and bolts. Match nuts and bolts efficiently.
Constraint: Comparison of a nut to another nut or a bolt to another bolt is not allowed. It means nut can only be compared with bolt and bolt can only be compared with nut to see which one is bigger/smaller.

Other way of asking this problem is, given a box with locks and keys where one lock can be opened by one key in the box. We need to match the pair.
*/

func partition(_ array: inout[Int], p: Int, r: Int, x: Int) -> Int {
    var i = p
    var j = p
    
    while j < r {
        // if smaller than pivot then keep swaping
        if array[j] < x {
            array.swapAt(i, j)
            i += 1
        }
        // If equal to pivot then move the equal one to end
        // then later we can swap to pivot index from last element
        else if array[j] == x {
            array.swapAt(j, r)
            // This is realy important to bring down the index so that
            // we can start comapring the new moved element with pivot
            j -= 1
        }
        j += 1
    }
    // bring the last element to pivot index
    array.swapAt(i, r)
    return i
}

// O(nlgn)
func matchPair(_ nuts: inout[Int], bolts: inout[Int], p: Int, r: Int) {
    if nuts.count != bolts.count { return }
    
    if p < r {
        // Do the randomization on bolts
        // and swap with last element which is the
        // pivot in our partition
        let pi = Int.random(in: p..<r)
        bolts.swapAt(pi, r)
        
        // Pass bolt last element as pivot
        let q = partition(&nuts, p: p, r: r, x: bolts[r])
        
        // Whatever q came as pivotIndex use it for bolts
        // to do the partition
        _ = partition(&bolts, p: p, r: r, x: nuts[q])
        
        matchPair(&nuts, bolts: &bolts, p: p, r: q - 1)
        matchPair(&nuts, bolts: &bolts, p: q + 1, r: r)
    }
}


var nuts = [3, 2, 1, 5, 6]
var bolts = [6, 5, 1, 2, 3]

matchPair(&nuts, bolts: &bolts, p: 0, r: nuts.count - 1)

print(nuts)
print(bolts)
