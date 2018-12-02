import Foundation

func zetaAlgorithm(ptrn: String) -> [Int]? {
    let pattern = Array(ptrn)
    let patternLength = ptrn.count
    
    guard patternLength > 0 else { return nil }
    
    var zeta = [Int](repeating: 0, count: patternLength)
    
    var left = 0
    var right = 0
    var k_1 = 0
    var betaLength = 0
    var textIndex = 0
    var patternIndex = 0
    
    for k in 1 ..< patternLength {
        if k > right { // If outside Z-Box
            patternIndex = 0
            while k + patternIndex < patternLength &&
                pattern[k + patternIndex] == pattern[patternIndex]{
                patternIndex += 1
            }
            zeta[k] = patternIndex
            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else { // Inside Z-Box
            k_1 = k - left + 1
            betaLength = right - k + 1
            
            if zeta[k_1 - 1] < betaLength {
                // Completely inside the Z-Box
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength {
                // Partially inside, need comparision
                textIndex = betaLength
                patternIndex = right + 1
                
                while patternIndex < patternLength &&
                    pattern[patternIndex] == pattern[textIndex] {
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

func kmp(ptnr: String, in source: String) -> [Int]? {
    let text = Array(source)
    let pattern = Array(ptnr)

    let textLength = text.count
    let patternLength = pattern.count
    
    guard pattern.count > 0 else { return nil }

    var suffixPrefix = [Int](repeating: 0, count: patternLength)
    var textIndex = 0
    var patternIndex = 0
    var indices = [Int]()
    
    // Pre-processing stage: computing the table for the shifts (through Z-Algorithm)
    let zetaIndices = zetaAlgorithm(ptrn: ptnr)
    
    guard let zeta = zetaIndices else { return nil }
    
    for patternIndex in (1 ..< patternLength).reversed() {
        textIndex = patternIndex + zeta[patternIndex] - 1
        suffixPrefix[textIndex] = zeta[patternIndex]
    }
    
    // Search stage: scanning the text for pattern matching
    textIndex = 0
    patternIndex = 0

    while textIndex + (patternLength - patternIndex - 1) < textLength {
        while patternIndex < patternLength &&
            pattern[patternIndex] == text[textIndex] {
            textIndex += 1
            patternIndex += 1
        }
        
        if patternIndex == patternLength {
            indices.append(textIndex - patternIndex)
        }
        
        if patternIndex == 0 {
            textIndex += 1
        } else {
            patternIndex = suffixPrefix[patternIndex - 1]
        }
    }
    return indices
}

let output = kmp(ptnr: "ACTGACTA", in: "GCACTGACTGACTGACTAG")
print(output)
