import UIKit

// https://leetcode.com/problems/evaluate-reverse-polish-notation/


class Solution {
    
    func evalRPN(_ tokens: [String]) -> Int {
        
        let n = tokens.count
        
        var stack: [Int] = []
        
        var index = 0
        while index < n {
            switch tokens[index] {
            case "+":
                let x = stack.removeLast()
                let y = stack.removeLast()
                stack.append(x + y)
                //let z = Int(x)! + Int(y)!
                //stack.append(String(z))
                
            case "-":
                let x = stack.removeLast()
                let y = stack.removeLast()
                stack.append(y - x)
                //let z = Int(y)! - Int(x)!
                //stack.append(String(z))
                
            case "*":
                let x = stack.removeLast()
                let y = stack.removeLast()
                stack.append(x * y)
                //let z = Int(x)! * Int(y)!
                //stack.append(String(z))
                
            case "/":
                let x = stack.removeLast()
                let y = stack.removeLast()
                stack.append(y / x)
                //let z = Int(y)! / Int(x)!
                //stack.append(String(z))
                
            default:
                stack.append(Int(tokens[index])!)
            }
            index += 1
        }
        return stack.last!
    }
    
}
