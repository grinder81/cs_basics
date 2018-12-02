import Foundation

// Time: O(m * n)

let prime = 101

extension Character {
    var asInt: Int {
        let s = String(self).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}

// Rolling hash function
func hash(array: [Int]) -> Double {
    var total: Double = 0
    var exponent = array.count - 1
    for i in array {
        total += Double(i) * pow(Double(prime), Double(exponent))
        exponent -= 1
    }
    return Double(total)
}

func nextHash(prevHash: Double, dropped: Int, added: Int, patternSize: Int) -> Double {
    let oldHash = prevHash - (Double(dropped) * pow(Double(prime), Double(patternSize)))
    return oldHash * Double(prime) + Double(added)
}

func search(pattern: String, in text: String) -> Int? {
    let patternArray = pattern.flatMap { $0.asInt }
    let textArray = text.flatMap { $0.asInt }
    
    guard textArray.count >= patternArray.count else { return nil }
    
    let patternHash = hash(array: patternArray)
    var endIdx = patternArray.count - 1
    let firstChars = Array(textArray[0...endIdx])
    let firstHash = hash(array: firstChars)
    
    if firstHash == patternHash {
        // Verify this was not a hash collison
        if firstChars == patternArray {
            return 0
        }
    }
    
    var prevHash = firstHash
    // Now slide the window across the text to be searched
    for index in 1 ... (textArray.count - patternArray.count) {
        endIdx = index + patternArray.count - 1
        let window = Array(textArray[index...endIdx])
        let windowHash = nextHash(prevHash: prevHash,
                                  dropped: textArray[index - 1],
                                  added: textArray[endIdx],
                                  patternSize: patternArray.count - 1)
        if patternHash == windowHash &&
            patternArray == window {
            return index
        }
        prevHash = windowHash
    }
    
    return nil
}

search(pattern: "ump", in: "iump")
