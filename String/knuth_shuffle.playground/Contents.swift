import Foundation

// The Fisher-Yates / Knuth shuffle

func shuffle(array: inout[Int]) {
    for i in stride(from: array.count - 1, through: 1, by: -1) {
        let j = Int.random(in: 0...i)
        if i != j {
            array.swapAt(i, j)
        }
    }
}

var array = [1, 2, 3, 4, 5, 6]
shuffle(array: &array)
print(array)

