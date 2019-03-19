import UIKit


// https://leetcode.com/problems/merge-intervals/submissions/

// Analysis:
// Sort the interval by start time
// Then find the intersection

public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

class Solution {
    func merge(_ intervals: [Interval]) -> [Interval] {
        guard intervals.count > 0 else { return [] }
        let n = intervals.count
        let array = intervals.sorted{ $0.start < $1.start}
        var result: [Interval] = []
        var i = 1
        // First element
        result.append(Interval(array[0].start, array[0].end))
        while i < n {
            let j = i
            var top = result.last!
            while i < n, array[i].start <= top.end {
                top.end = max(top.end, array[i].end)
                i += 1
            }
            if i < n {
                result.append(array[i])
            }
            i += 1
        }
        return result
    }
}
