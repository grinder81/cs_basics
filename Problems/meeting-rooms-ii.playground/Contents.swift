import UIKit

// https://leetcode.com/problems/meeting-rooms-ii/



public class Interval {
  public var start: Int
  public var end: Int
  public init(_ start: Int, _ end: Int) {
    self.start = start
    self.end = end
  }
}

class Solution {
    func minMeetingRooms(_ intervals: [Interval]) -> Int {
        guard !intervals.isEmpty else { return 0 }
        
        let n = intervals.count
        
        var start: [Int] = []
        var end: [Int] = []
        intervals.forEach{ x in
            start.append(x.start)
            end.append(x.end)
        }
        
        start.sort()
        end.sort()
        
        var totalRooms = 0
        var sIndex = 0
        var eIndex = 0
        
        while sIndex < n {
            // If there is a meeting that has ended by
            // the time the meeting at `start_pointer` starts
            if start[sIndex] >= end[eIndex] {
                // Release the room now
                totalRooms -= 1
                eIndex += 1
            }
            totalRooms += 1
            sIndex += 1
        }
        
        return totalRooms
    }
}

