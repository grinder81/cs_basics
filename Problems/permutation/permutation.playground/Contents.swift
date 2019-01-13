import UIKit
/**
                                [1, 2, 3 k = 0]
                    [1, 2, 3 = 1]               [2, 1, 3 k = 1]
            [1, 2, 3 k = 2] [1, 3, 2 k = 2]  [2, 3, 1 k = 2]    [2, 1, 3]
 */
func permutation(_ input: inout[Int], _ k: Int) {
    if k == input.count - 1 {
        // new permutation
        print(input)
        return
    }
    for i in k..<input.count {
        input.swapAt(i, k)
        permutation(&input, k + 1)
        input.swapAt(i, k)
    }
}

// O(n)
func nextPermutation(_ input: [Int]) -> [Int] {
    var p: [Int] = Array(input)
    let n = p.count
    // find k where: p[k] <= p[k+1]
    var k = n - 2
    while k >= 0 && p[k] >= p[k + 1] {
        k -= 1
    }
    if k == -1 { return [] }
    
    // find l where: p[k] <= p[l]
    var l = n - 1
    while l > k && p[l] <= p[k]  {
        l -= 1
    }
    
    // swap p[k] and p[l]
    p.swapAt(k, l)

    // reverse p[k+1 to n-1]
    var left    = k + 1
    var right   = n - 1
    while left <= right {
        p.swapAt(left, right)
        left    += 1
        right   -= 1
    }
    return p
}

func permutationIteration(_ input: [Int]) {
    var a = input.sorted()
    repeat {
        print(a)
        a = nextPermutation(a)
    } while !a.isEmpty
}

nextPermutation([3, 2, 1])

var input = [1, 2, 3]
permutation(&input, 0)
