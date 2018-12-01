import Foundation

// https://www.youtube.com/watch?v=MFK0WYeVEag

// Defination: Given a string S, Z[i](S) = length of the
// longest substring in S, starting at position i that matches the PREFIX of S.

// Prefix: Begining of the String. We will use S = P + $ + T to create main
// string and then Zi(S) will be generated from there.

// Steps: Find all Zi values in S where S =  S + $ +T, and Zi = |P|
// identifies an occurance of P in T

func zetaAlgorithm(ptrn: String) -> [Int]? {
    let pattern = Array(ptrn)
    let patternLength: Int = pattern.count
    
    guard patternLength > 0 else {
        return nil
    }
    
    var zeta: [Int] = [Int](repeating: 0, count: patternLength)
    
    var left: Int = 0
    var right: Int = 0
    var k_1: Int = 0
    var betaLength: Int = 0
    var textIndex: Int = 0
    var patternIndex: Int = 0
    
    for k in 1 ..< patternLength {
        if k > right { // Outside a Z-box: compare the characters until mismatch
            patternIndex = 0
            // Use two finger comparision
            while k + patternIndex < patternLength &&
                pattern[k + patternIndex] == pattern[patternIndex] {
                patternIndex += 1
            }
            
            zeta[k] = patternIndex
            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else { // Inside a Z-box
            k_1 = k - left + 1
            betaLength = right - k + 1
            
            if zeta[k_1 - 1] < betaLength {
                // // Entirely inside a Z-box: we can use the values computed before
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength {
                // Not entirely inside a Z-box: we must proceed with comparisons too
                textIndex = betaLength
                patternIndex = right + 1
                
                while patternIndex < patternLength && pattern[textIndex] == pattern[patternIndex] {
                    textIndex += 1
                    patternIndex += 1
                }
                zeta[k] = patternIndex - k
                left = k
                right = patternIndex - 1
            }
        }
    }
    return zeta
}

func indexesOf(pattern: String, in source: String) -> [Int]? {
    let parrentLength = pattern.count
    // Consider there is no `$` in source and pattern
    let zetaIndices = zetaAlgorithm(ptrn: pattern + "$" + source)
    
    guard let zeta = zetaIndices else { return nil }
    
    var indexes: [Int] = [Int]()
    for i in 0 ..< zeta.count  {
        if zeta[i] == parrentLength {
            indexes.append(i - parrentLength - 1)
        }
    }
    
    if indexes.count == 0 { return nil }
    
    return indexes
}

let output = indexesOf(pattern: "CATA", in: "GAGAACATACATGACCAT")
print(output)
