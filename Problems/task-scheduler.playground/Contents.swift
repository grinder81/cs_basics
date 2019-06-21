import UIKit

// https://leetcode.com/problems/task-scheduler/

class Solution {
    
    private func methodOne(_ tasks: [Character], _ n: Int) -> Int {
        var map: [Character: Int] = [:]
        for c in tasks {
            if map[c] == nil {
                map[c] = 1
            } else {
                map[c]! += 1
            }
        }
        
        // Constant time O(26)
        var sortedMap = map.sorted { $0.value > $1.value }
        let len = sortedMap.count
        var count = 0
        
        return count + tasks.count
    }
    
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        return methodOne(tasks, n)
    }
}

let s = Solution()
s.leastInterval(["A","A","A","B","B", "B"], 3)
