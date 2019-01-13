import UIKit

func isValid(_ row: Int, _ col: Int, _ result: [Int]) -> Bool {
    for (rowIndex, prevCol) in result.enumerated().dropLast() {
        let colDiff = abs(col - prevCol)
        let rowDiff = abs(row - rowIndex)
        if colDiff == 0 || colDiff == rowDiff {
            return false
        }
    }
    return true
}

func nQueen(_ k: Int, _ n: Int, _ result: inout[Int]) {
    if k == n {
        print(result)
        return
    }
    for index in 0..<n {
        result.append(index)
        if isValid(k, index, result) {
            nQueen(k + 1, n, &result)
        }
        result.removeLast()
    }
}

var result: [Int] = []
nQueen(0, 4, &result)
