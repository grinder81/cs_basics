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

//"110010"
//"10111"

var a1 = "110010"
var a2 = "10111"
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


func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    /// target = nums[i] + z
    /// z = target - nums[i]
    /// we look up z in set
    /// if exsit then return i and set.value
    var set: [Int: Int] = [:]
    let n = nums.count
    for index in 0..<n {
        if let value = set[nums[index]] {
            return [value, index]
        }
        set[target - nums[index]] = index
    }
    return []
}

twoSum([2, 7, 11, 15], 9)


func twoSum(_ nums: [Int], fromIndex: Int, target: Int) -> [[Int]] {
    print(target)
    let n = nums.count
    var set: [Int: Int] = [:]
    var result: [[Int]] = []
    /// x = y + z
    /// z = (x == target) - (y == nums[index])
    for index in fromIndex..<n {
        if let value = set[nums[index]] {
            result.append([value, index])
        }
        let z = target - nums[index]
        set[z] = index
    }
    return result
}

/// https://leetcode.com/problems/3sum/submissions/
func threeSum(_ nums: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    
    let n = nums.count
    let array = nums.sorted()
    var index = 0
    while index < (n - 2) {
        let sum = array[index] * -1
        var l = index + 1
        var r = n - 1
        
        while l < r {
            if sum == array[l] + array[r] {
                result.append([array[index], array[l], array[r]])
                while l < r && array[l] == array[l + 1] {
                    l += 1
                }
                while l < r && array[r] == array[r - 1] {
                    r -= 1
                }
                l += 1
                r -= 1
            } else if sum > array[l] + array[r] {
                l += 1
            } else {
                r -= 1
            }
        }
        
        while index < n - 1 && array[index] == array[index + 1] {
            index += 1
        }
        index += 1
    }
    return result
}
/// -4, -1, -1, 0, 1, 2
threeSum([-1, 0, 1, 2, -1, -4])


/// https://leetcode.com/problems/3sum-closest/

func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    let array = nums.sorted()
    let n = nums.count
    
    var result = target
    var closest = Int.max
    
    /// T = A + B + C
    /// target - T === 0 is the best or
    /// target - T close to 0 is the 2nd best
    
    var index = 0
    while index < (n - 2) {
        var l = index + 1
        var r = n - 1
        
        while l < r {
            /// A + B + C
            let t = array[index] + array[l] + array[r]
            let d = target - t
            if d == 0 {
                return t
            } else if d > 0 {
                l += 1
            } else {
                r -= 1
            }
            if abs(d) < closest {
                closest = abs(d)
                result = t
            }
        }
//        while index < n - 1 && array[index] == array[index + 1] {
//            index += 1
//        }
        index += 1
    }
    return result
}

/// -1, 1, 2
/// -1 + 1 + 2 = 2
/// 2 - (-1 + 1)
/// T = 2, target = 1

threeSumClosest([0, 1, 2], 3)

func palindromeExtension(_ array: [Character], leftDir: Int, rightDir: Int) ->(Int, Int) {
    var l = leftDir
    var r = rightDir
    
    while l >= 0 && r < array.count && array[l] == array[r] {
        l -= 1
        r += 1
    }
    return (l + 1, r - l - 1)
}

func longestPalindrome(_ s: String) -> String {
    let array = Array(s)
    let n = array.count

    if n < 2 { return s }
    
    var palindrom: (Int, Int) = (0, Int.min)
    
    for index in 0..<n-1 {
        let v1 = palindromeExtension(array, leftDir: index, rightDir: index)
        if v1.1 > palindrom.1 {
            palindrom = v1
        }
        let v2 = palindromeExtension(array, leftDir: index, rightDir: index + 1)
        if v2.1 > palindrom.1 {
            palindrom = v2
        }
    }

    let leftIndex   = s.index(s.startIndex, offsetBy: palindrom.0)
    let rightIndex  = s.index(s.startIndex, offsetBy: palindrom.0 + palindrom.1)
    return String(s[leftIndex..<rightIndex])
}

longestPalindrome("babad")

func isValid(_ s: String) -> Bool {
    let array = Array(s)
    let n = array.count
    
    if n == 0 { return true }
    let bracketsHash: [Character: Character] = [")": "(", "}": "{", "]": "["]
    var stack: [Character] = []
    var index = 0
    while index < n {
        if bracketsHash.values.contains(array[index]) {
            stack.append(array[index])
        } else {
            if let opening = bracketsHash[array[index]], stack.count > 0, opening == stack.last!  {
                stack.removeLast()
            } else {
                return false
            }
        }
        index += 1
    }
    
    return stack.count == 0
}

isValid("[")


// https://leetcode.com/problems/longest-valid-parentheses/
func longestValidParentheses(_ s: String) -> Int {
    let array = Array(s)
    let n = array.count
    
    if n == 0 { return 0 }
    var stack: [Int] = []
    var maxLen = 0
    var index = 0
    
    stack.append(-1)
    
    while index < n {
        if array[index] == "(" {
            stack.append(index)
        } else {
            if stack.count > 0 {
                stack.removeLast()
            }
            if let last = stack.last {
                maxLen = max(maxLen, index - last)
            } else {
                stack.append(index)
            }
        }
        index += 1
    }
    return maxLen
}


/// ((()))
/// ()()
/// ()
/// ()(()
/// (())(())

longestValidParentheses("()())")


/// https://leetcode.com/problems/valid-parenthesis-string/
/**
    Any left parenthesis '(' must have a corresponding right parenthesis ')'.
    Any right parenthesis ')' must have a corresponding left parenthesis '('.
    Left parenthesis '(' must go before the corresponding right parenthesis ')'.
    '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string.
    An empty string is also valid.\
 **/
func checkValidString(_ s: String) -> Bool {
    let array = Array(s)
    let n = array.count
    
    if n == 0 { return true }
    
    var leftIds: [Int] = []
    var starIds: [Int] = []
    
    for index in 0..<n {
        if array[index] == "(" {
            leftIds.append(index)
        } else if array[index] == "*" {
            starIds.append(index)
        } else {
            if leftIds.count == 0 &&
               starIds.count == 0 {
                return false
            }
            if leftIds.count > 0 {
                _ = leftIds.removeLast()
            } else {
                _ = starIds.removeLast()
            }
        }
    }

    while leftIds.count > 0 && starIds.count > 0 {
        if leftIds.last! > starIds.last! {
            return false
        }
        _ = leftIds.removeLast()
        _ = starIds.removeLast()
    }
    return leftIds.count == 0
}

/// ((*)    -> * as right
/// (*))    -> * as Left
/// (*)     -> * as empty
/// ***))
/// *)(
/// ((******

let r  = checkValidString("((()))()(())(*()()())**(())()()()()((*()*))((*()*)")
print(r)

func validPalindrome(_ s: String) -> Bool {
    let array = Array(s)
    let n = array.count
    
    if n <= 1 { return true }
    
    var l = 0
    var r = n - 1
    
    while l <= r {
        if array[l] == array[r] {
            l += 1
            r -= 1
        } else {
            var ll = l + 1
            var lr = r
            while ll <= lr && array[ll] == array[lr] {
                ll += 1
                lr -= 1
            }
            if ll >= lr { return true }
            
            var rl = l
            var rr = r - 1
            while rl <= rr && array[rl] == array[rr] {
                rl += 1
                rr -= 1
            }
            if rl >= rr { return true }
            
            return false
        }
    }
    return true
}

/// abc
/// eeede

let p = validPalindrome("deeee")
print(p)

func addBinary(_ a: String, _ b: String) -> String {
    let A = Array(a)
    let B = Array(b)
    
    let nA = A.count
    let nB = B.count
    
    if nA == 0 { return b }
    if nB == 0 { return a }
    
    let binaryAdd = { (a1: Character, a2: Character) -> (Character, Character) in
        if a1 == "1" && a2 == "1" {
            return ("0", "1")
        }
        if a1 == "0" && a2 == "1" {
            return ("1", "0")
        }
        if a1 == "1" && a2 == "0" {
            return ("1", "0")
        }
        return ("0", "0")
    }
    
    var aIndex = nA - 1
    var bIndex = nB - 1
    var carry: Character = "0"
    var result: [Character] = []
    while aIndex >= 0 &&  bIndex >= 0 {
        /// r = a + b + c
        /// 1 + 1 = (0, 1) A + B
        /// 0 + 1 = (1, 0) R + C
        let r1 = binaryAdd(A[aIndex], B[bIndex])
        let r2 = binaryAdd(r1.0, carry)
        carry = r1.1
        result.append(r2.0)
        aIndex -= 1
        bIndex -= 1
    }
    
    while aIndex >= 0 {
        let r = binaryAdd(A[aIndex], carry)
        carry = r.1
        result.append(r.0)
        aIndex -= 1
    }
    
    while bIndex >= 0 {
        let r = binaryAdd(B[bIndex], carry)
        carry = r.1
        result.append(r.0)
        bIndex -= 1
    }
    result.append(carry)
    return String(result.reversed())
}

let ss = addBinary("11", "11111")
print(ss)


/// https://leetcode.com/problems/trapping-rain-water/

func trap(_ height: [Int]) -> Int {
    if height.count < 2 { return 0 }
    
    let n = height.count
    var trapArea = 0
    var index = 0
    
    /// Without stack
    var l = 0
    var r = n - 1
    var lMax = 0
    var rMax = 0
    
    while l < r {
        if height[l] < height[r] {
            if height[l] >= lMax {
                lMax = height[l]
            } else {
                trapArea += (lMax - height[l])
            }
            l += 1
        } else {
            if height[r] >= rMax {
                rMax = height[r]
            } else {
                trapArea += (rMax - height[r])
            }
            r -= 1
        }
    }
    
    /// With Stack
    /*
    var s: [Int] = []
    
    while index < n {
        // if current height is less than or equal to
        // stack top then keep adding to stack
        if s.count == 0 || height[index] <= height[s.last!] {
            s.append(index)
            index += 1
        } else {
            // This is the one is holding water
            let r = s.removeLast()
            if s.count > 0 {
                // Find the min of current height and the
                // top of the stack
                let h = min(height[index], height[s.last!])
                let water = (index - s.last! - 1) * (h - height[r])
                trapArea += water
            }
        }
    }
    */
    
    return trapArea
}

let t = trap([2, 1, 2])
print(t)


// https://leetcode.com/problems/largest-rectangle-in-histogram/

func largestRectangleArea(_ heights: [Int]) -> Int {
    if heights.count == 0 { return 0 }
    
    let n = heights.count
    
    var maxArea = 0
    var lessFromLeft    = Array<Int>(repeating: 0, count: n)
    var lessFromRight   = Array<Int>(repeating: 0, count: n)
    
    lessFromLeft[0] = -1
    lessFromRight[n - 1] = n
    
    var i = 1
    while i < n {
        var p = i - 1
        while p >= 0 && heights[p] >= heights[i] {
            p = lessFromLeft[p]
        }
        lessFromLeft[i] = p
        i += 1
    }
    
    i = n - 2
    while i >= 0 {
        var p = i + 1
        while p < n && heights[p] >= heights[i] {
            p = lessFromRight[p]
        }
        lessFromRight[i] = p
        i -= 1
    }
    
    i = 0
    while i < n {
        maxArea = max(maxArea, heights[i] * (lessFromRight[i] - lessFromLeft[i] - 1))
        i += 1
    }
    
    /// Stack based
    /*
     var stack: [Int] = []
     var maxArea = 0
     var i = 0
     
     
     while i < n {
     let h = heights[i]
     if stack.count == 0 || h >= heights[stack.last!] {
     stack.append(i)
     i += 1
     } else {
     let top = stack.removeLast()
     // if there is no element on the stack then
     // i itself is the whole length
     // otherwise anything
     // h[stack.last + 1] >= h[top]
     let area = (stack.count == 0 ? i : (i - 1 - stack.last!)) * heights[top]
     maxArea = max( maxArea, area)
     }
     }
     
     while stack.count != 0 {
     let top = stack.removeLast()
     let area = (stack.count == 0 ? i : (i - 1 - stack.last!)) * heights[top]
     maxArea = max( maxArea, area)
     }
     */
    
    // Tricky way
    /*
     while i <= n {
     let h = i == n ? 0 : heights[i]
     if stack.count == 0 || h >= heights[stack.last!] {
     stack.append(i)
     } else {
     let top = stack.removeLast()
     // if there is no element on the stack then
     // i itself is the whole length
     // otherwise anything
     // h[stack.last + 1] >= h[top]
     let area = stack.count == 0 ? i : (i - 1 - stack.last!) * heights[top]
     maxArea = max( maxArea, area)
     i -= 1
     }
     i += 1
     }
     */
    
    return maxArea
}


/// For Max-Heap
/// 1. At anytime root node is the max value
/// 2. Both child of a parent node is <= to parent node value
/// 3. For node i
///     a. left = 2 * i + 1
///     b. right = 2 * i + 2
///     c. parent = (i - i) / 2
/// 4. Accessing top value is O(1)
/// 5. Adding or removing is O(lg n)

class Heap {
    private var data: [Int] = []
    private(set) var size: Int = 0
    
    func parent(of i: Int) -> Int {
        return (i - 1) / 2
    }
    
    func left(childOf i: Int) -> Int {
        return 2 * i + 1
    }
    
    func right(childOf i: Int) -> Int {
        return 2 * i + 2
    }
    
    var peek: Int? {
        return data.first
    }
}

extension Heap {
    /// Public funcsions
    /// 1. insert
    /// 2. sort
    /// 3. sortArray
    /// 4. buildMaxHeap
    
    func insert(_ key: Int) {
        // 1. Add min value to end of the array
        // 2. Increase the size
        // 3. reHeapify
        data.append(Int.min)
        size += 1
        replace(at: size - 1, key: key)
    }
    
    func pop() {
        if size == 0 { return }
        data.swapAt(0, size - 1)
        size -= 1
        maxHeapify(0)
    }
    
    /// We only need to heapify parents
    /// and all parents nodes are [0...n/2 - 1]
    /// O(n lg n)
    func buildHeap(from array: [Int]) {
        data = array
        size = array.count
        for index in stride(from: (size/2 - 1), through: 0, by: -1) {
            maxHeapify(index)
        }
    }
    
    func sort() -> [Int] {
        for index in stride(from: data.count - 1, through: 1, by: -1) {
            data.swapAt(0, index)
            size -= 1
            maxHeapify(0)
        }
        return data
    }
    
    private func maxHeapify(_ i: Int) {
        let lChildIndex = left(childOf: i)
        let rChildIndex = right(childOf: i)
        
        var largetsOne = i
        
        if lChildIndex < size && data[lChildIndex] > data[largetsOne] {
            largetsOne = lChildIndex
        }
        
        if rChildIndex < size && data[rChildIndex] > data[largetsOne] {
            largetsOne = rChildIndex
        }
        
        if largetsOne != i {
            data.swapAt(i, largetsOne)
            maxHeapify(largetsOne)
        }
    }
    
    private func replace(at index: Int, key: Int) {
        assert(key > data[index], "key smaller than current value")
        var i = index
        data[i] = key
        while i > 0 && data[parent(of: i)] < data[i] {
            data.swapAt(parent(of: i), i)
            i = parent(of: i)
        }
    }
}

let heap = Heap()
heap.insert(100)
heap.insert(200)
heap.insert(20)
heap.insert(10)
heap.insert(300)

print(heap.peek)

heap.pop()

print(heap.peek)

heap.sort()

/// https://leetcode.com/problems/find-median-from-data-stream/submissions/
class MedianFinder {
    
    var smallMaxHeap = Heap()
    var largeMinHeap = Heap()
    
    /** initialize your data structure here. */
    init() {
        
    }
    
    func addNum(_ num: Int) {
        smallMaxHeap.insert(num)
        largeMinHeap.insert(-smallMaxHeap.peek!)
        smallMaxHeap.pop()
        if smallMaxHeap.size < largeMinHeap.size {
            smallMaxHeap.insert(-largeMinHeap.peek!)
            largeMinHeap.pop()
        }
    }
    
    func findMedian() -> Double {
        let m = smallMaxHeap.size > largeMinHeap.size ? Double(smallMaxHeap.peek!) : Double(smallMaxHeap.peek! - largeMinHeap.peek!) / Double(2)
        return Double(m)
    }
}

func tileTriominos(_ n: Int, _ bottomRight: (Int, Int), _ array: inout[[Int]], _ size: Int, _ p: (Int, Int)) {
    if n == 2 {
        print(bottomRight)
        return
    }
    // first quadrent
    let c1 = (bottomRight.0, bottomRight.1 - n / 2)
    let c2 = (bottomRight.0 - n / 2, bottomRight.1 - n / 2)
    let c3 = (bottomRight.0 - n / 2, bottomRight.1)
    let c4 = (bottomRight.0, bottomRight.1)
    
    tileTriominos(n / 2, c1, &array, size, p)
    tileTriominos(n / 2, c2, &array, size, p)
    tileTriominos(n / 2, c3, &array, size, p)
    tileTriominos(n / 2, c4, &array, size, p)
}

var tile: [[Int]] = [[]]
//tileTriominos(2, (1, 1), &tile, 2, (0, 0))
//tileTriominos(4, (4, 4), &tile, 4, (0, 0))
//tileTriominos(8, (8, 8), &tile, 8, (0, 0))
tileTriominos(16, (16, 16), &tile, 16, (0, 0))

extension Character {
    var asInt: Int {
        let s = String(self).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}

class RobinKarp {
    
    let prime = 101
    
    private func hash(_ nums: [Int]) -> Double {
        var exp = nums.count - 1
        var value: Double = 0
        var i = 0
        while i < nums.count {
            value += Double(nums[i]) * pow(Double(prime), Double(exp))
            i += 1
            exp -= 1
        }
        return value
    }
    
    private func nextHash(_ value: Double, _ oldValue: Int, _ newValue: Int, _ n: Int) -> Double {
        // x1 * p^n-1 + x2 * p^n-2 + x3*p^n-3
        let h1 = Double(oldValue) * pow(Double(prime), Double(n-1))
        let r = value - h1
        return r * Double(prime) + Double(newValue)
    }
    
    func subString(_ s: String, _ p: String) -> Int? {
        guard !s.isEmpty else {
            return nil
        }
        
        let pattern = Array(p.compactMap{ $0.asInt })
        let text = Array(s.compactMap{ $0.asInt })
        
        let pLen = pattern.count
        let sLen = text.count
        
        guard sLen >= pLen else { return nil }
        
        let patternHash = hash(pattern)
        
        var window = Array(text[0...(pLen - 1)])
        var windowHash = hash(window)
        
        // Early check
        if patternHash == windowHash, pattern == window {
            return 0
        }
        
        var i = 1
        var prevHash = windowHash
        while i < (sLen - pLen + 1) {
            window = Array(text[i...(i + pLen - 1)])
            windowHash = nextHash(prevHash, text[i - 1], text[i + pLen - 1], pLen)
            if windowHash == patternHash, pattern == window {
                return i
            }
            prevHash = windowHash
            i += 1
        }
        
        // Find the hash of the pattern
        // Use rolling hash to find the pattern
        
        return nil
    }
    
}

let robinK = RobinKarp()
robinK.subString("aas", "s")


