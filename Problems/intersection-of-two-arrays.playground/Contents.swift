import UIKit

// https://leetcode.com/problems/intersection-of-two-arrays/

class Solution {
    private func methodCustom(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let a = nums1.sorted()
        let b = nums2.sorted()
        
        let m = a.count
        let n = b.count
        
        // If either one is empty
        if m == 0 || n == 0 {
            return []
        }
        
        var result = Set<Int>(minimumCapacity: min(m, n))
        
        var i = 0
        var j = 0
        
        while i < m && j < n {
            if a[i] == b[j] {
                result.insert(a[i])
                i += 1
                j += 1
            } else if a[i] < b[j] {
                i += 1
            } else {
                j += 1
            }
        }
        
        return Array(result)
    }
    
    private func methodSet(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let setA = Set(nums1)
        let setB = Set(nums2)
        
        return Array(setA.intersection(setB))
    }
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        return methodSet(nums1, nums2)
    }
}
