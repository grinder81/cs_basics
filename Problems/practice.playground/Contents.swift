import UIKit

func twoWayPartition(array: inout[Int], p: Int, r: Int) -> Int {
    var low = p - 1
    
    // pivot element
    let x = array[r]
    
    /// [p-----low-1] [low] [low + 1----r]
    /// [p----low] [low+1----high-1] [high---r-1] [r]
    
    /// array[p..low]: <= x
    /// array[low+1..high-1]: > x
    /// array[high..r-1]: Unknown
    /// array[r] == x
    
    for high in p...r-1 {
        if array[high] <= x {
            low += 1
            array.swapAt(low, high)
        }
    }
    
    // place the pivot in right place
    array.swapAt(low + 1, r)
    
    return low + 1
}

func quickSortByTwoWay(array: inout[Int], p: Int, r: Int) {
    if p < r {
        // randomize
        let pi = Int.random(in: p..<r)
        array.swapAt(pi, r)
        
        // two way partition
        let q = twoWayPartition(array: &array, p: p, r: r)
        
        quickSortByTwoWay(array: &array, p: p, r: q - 1)
        quickSortByTwoWay(array: &array, p: q + 1, r: r)
    }
}

var array = [4, 1, -1, 3, 2]
quickSortByTwoWay(array: &array, p: 0, r: array.count - 1)


func threeWayPartitioning(array: inout[Int], p: Int, r: Int) -> (Int, Int) {
    /// [p...low-1] [low] [low+1...r]
    /// [p...low-1] [low...mid-1] [mid...high-1] [high...r-1] [r]
    
    var low = p
    var high = r
    var mid = p
    
    /// Pivot element
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


func quickSortByThreeWay(array: inout[Int], p: Int, r: Int) {
    if p < r {
        let pi = Int.random(in: p..<r)
        array.swapAt(pi, r)
        
        let q = threeWayPartitioning(array: &array, p: p, r: r)
        quickSortByThreeWay(array: &array, p: p, r: q.0)
        quickSortByThreeWay(array: &array, p: q.1, r: r)
    }
}

var array1 = [10, -2, 3, 1, 5, 7, 0]
quickSortByTwoWay(array: &array1, p: 0, r: array1.count - 1)


// Re-order an array element so that even element at first

func evenElementAtFirst(array: inout[Int]) {
    var low = 0
    var high = array.count - 1
    
    /// [0...mid] [mid...high] [high...r]
    
    while low < high {
        if array[low] % 2 == 0 {
            low += 1
        } else {
            array.swapAt(low, high)
            high -= 1
        }
    }
}

var array2 = [2, 1, 3, 5, 6, 2]
evenElementAtFirst(array: &array2)

/// Array has 0,1 and 2. Group same type

func segmentation012(array: inout[Int]) {
    var low = 0
    var high = array.count - 1
    var mid = 0
    
    /// [0...low] [low+1...mid] [mid...high]
    
    while mid <= high {
        switch array[mid] {
        case 0:
            array.swapAt(low, mid)
            low += 1
            mid += 1
        case 1:
            mid += 1
        default:
            array.swapAt(mid, high)
            high -= 1
        }
    }
}

var array3 = [2, 1, 2, 2, 0, 0]
segmentation012(array: &array3)


// Given array A and partition 4 elements

func partition0123(array: inout[Int]) {
    var zero = 0
    var mid = 0
    
    var one = array.count - 1

    while mid <= one {
        if array[mid] == 0 {
            array.swapAt(zero, mid)
            zero += 1
            mid += 1
        } else if array[mid] == 1 {
             mid += 1
        } else {
            array.swapAt(mid, one)
            one -= 1
        }
    }
    
    var two = mid
    var three = array.count - 1
    
    while mid <= three {
        if array[mid] == 2 {
            array.swapAt(two, mid)
            two += 1
            mid += 1
        } else if array[mid] == 3 {
            mid += 1
        } else {
            array.swapAt(mid, three)
            three -= 1
        }
    }
    
    print(mid)
}

var array4 = [3, 3, 2, 3, 2, 1, 0, 0, 1, 2, 1, 3, 3, 1, 2]
partition0123(array: &array4)

// Conver array element

func encodeElementByOne(array: inout[Int]) {
    guard array.count > 0 else { return }
    
    var index = array.count - 1
    array[index] += 1
    var carry = 0
    while index != -1 {
        let sum = (array[index] + carry)
        let digit = sum % 10
        carry = sum / 10
        array[index] = digit
        index -= 1
        
        if carry == 0 { break }
    }
    if carry != 0 {
        array.insert(carry, at: 0)
    }
}

var arrayEncode = [9, 9, 9]
encodeElementByOne(array: &arrayEncode)

func binarySum(a1: [Character], a2: [Character]) -> String {
    var result = Array<Character>()
    
    let binarySumOperation = { (e1: Character, e2: Character) -> (Character, Character) in
        if e1 == "1" && e2 == "1" {
            return ("0", "1")
        }
        if e1 == "1" || e2 == "1" {
            return ("1", "0")
        }
        return ("0", "0")
    }
    
    let n1 = a1.count
    let n2 = a2.count
    
    var a1Index = 0
    var a2Index = 0
    var carry: Character = "0"
    
    while a1Index < n1 && a2Index < n2 {
        let sum1 = binarySumOperation(a1[a1Index], a2[a2Index])
        let sum2 = binarySumOperation(sum1.0, carry)
        let carrySum = binarySumOperation(sum1.1, sum2.1)
        carry = carrySum.0
        result.append(sum2.0)
        a1Index += 1
        a2Index += 1
    }
    
    while a1Index < n1 {
        let sum = binarySumOperation(a1[a1Index], carry)
        carry = sum.1
        result.append(sum.0)
        a1Index += 1
    }
    result.append(carry)
    return String(result.reversed())
}

func addBinaryString(b1: String, b2: String) -> String {
    
    if b1.count == 0 { return b2 }
    if b2.count == 0 { return b1 }
    
    var a1 = Array(b1.reversed())
    var a2 = Array(b2.reversed())
    
    if a1.count > a2.count {
        return binarySum(a1: a1, a2: a2)
    } else {
        return binarySum(a1: a2, a2: a1)
    }
}

var a1 = "11"
var a2 = "1"
addBinaryString(b1: a1, b2: a2)

func longgestEqaulSubArray(_ array: [Int]) -> Int {
    if array.count <= 1 { return array.count }

    var maxLen = Int.min
    var index = 1
    var counter = 1
    let n = array.count

    while index < n {
        if array[index] != array[index - 1] {
            maxLen = max(counter, maxLen)
            counter = 1
        } else {
            counter += 1
        }
        index += 1
    }
    maxLen = max(counter, maxLen)
    return maxLen
}

// 1111221451
var subArray = [1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 4, 5, 1, 1]
longgestEqaulSubArray(subArray)


func sievePrime(_ n: Int) -> [Int] {
    var primes: [Int] = []
    var sieveFlag = Array<Bool>(repeating: true, count: n + 1)
    sieveFlag[0] = false
    sieveFlag[1] = false
    for index in 2...n {
        if sieveFlag[index] {
            primes.append(index)
            var p = index * 2
            while p <= n {
                sieveFlag[p] = false
                p += index
            }
        }
    }
    return primes
}

sievePrime(100)

/// https://leetcode.com/problems/container-with-most-water/
func maxArea(_ height: [Int]) -> Int {
    let n = height.count
    var maxArea = 0
    
    var l = 0
    var r = n - 1
    while l < r {
        let h = min(height[l], height[r])
        maxArea = max(maxArea, (r - l) * h)
        while height[l] <= h && l < r {
            l += 1
        }
        while height[r] <= h && l < r {
            r -= 1
        }
    }
    return maxArea
}
maxArea([2,3,4,5,18,17,6])
