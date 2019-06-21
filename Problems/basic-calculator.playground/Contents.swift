import UIKit

// https://leetcode.com/problems/basic-calculator/

extension Character {
    var asInt: Int {
        return Int(String(self))!
    }
    
    var isDigit: Bool {
        return self >= "0" && self <= "9"
    }
}

class Solution {
    func calculate(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        
        let array = Array(s)
        let n = array.count
        
        var stack: [Int] = []
        var index = 0
        var number = 0
        var result = 0
        var opertion = 1
        while index < n {
            if array[index].isDigit {
                number = number * 10 + array[index].asInt
            } else if array[index] == "+" {
                result += opertion * number
                opertion = 1
                number = 0
            } else if array[index] == "-" {
                result += opertion * number
                opertion = -1
                number = 0
            } else if array[index] == "(" {
                stack.append(result)
                stack.append(opertion)
                result = 0
                opertion = 1
            } else if array[index] == ")" {
                result += opertion * number
                number = 0
                result *= stack.removeLast()
                result += stack.removeLast()
            }
            index += 1
        }
        if number != 0 {
            result += opertion * number
        }
        return result
    }
}

let s = Solution()
s.calculate("(1+(4+5+2)-3)+(6+8)")
