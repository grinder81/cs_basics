import UIKit

// https://leetcode.com/problems/integer-to-roman/

class Solution {
    let Symbol: [Int: String] = [1: "I",
                                 2: "II",
                                 3: "III",
                                 4: "IV",
                                 5: "V",
                                 9: "IX",
                                 10: "X",
                                 40: "XL",
                                 50: "L",
                                 90: "XC",
                                 100: "C",
                                 400: "CD",
                                 500: "D",
                                 900: "CM",
                                 1000: "M"]
    
    // O(15 * n) where is number of iteration for number 
    private func methodOne(_ num: Int) -> String {
        let keys = Symbol.keys.sorted{ $0 > $1 }
        
        var result = ""
        var num = num
        while num >= 1 {
            var i = 0
            while i < keys.count, num < keys[i] {
                i += 1
            }
            if i == keys.count {
                break
            }
            result += Symbol[keys[i]] ?? ""
            num -= keys[i]
        }
        return result
    }
    
    func intToRoman(_ num: Int) -> String {
        return methodOne(num)
    }
}

let s = Solution()
s.intToRoman(101)
