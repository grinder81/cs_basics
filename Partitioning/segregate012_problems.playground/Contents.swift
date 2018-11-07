import Foundation

func segregate012V1(_ array: inout[Int]) {
    var low     = 0
    var mid     = 0
    var high    = array.count - 1
    
    // array[0..low-1]      = 0's
    // array[low..mid-1]    = 1's
    // array[mid..high-1]   = Unknown
    // array[high..N-1]     = 2's
    
    while mid <= high {
        switch array[mid] {
        case 0:
            array.swapAt(low, mid)
            low += 1
            mid += 1
        case 1:
            mid += 1
        default:
            array.swapAt(mid, high)
            high -= 1
        }
    }
}

func segregate012V2(_ array: inout[Int]) {
    var zeroCounter = 0
    var oneCounter  = 0
    var twoCounter  = 0
    
    for item in array {
        switch item {
        case 0:
            zeroCounter += 1
        case 1:
            oneCounter += 1
        default:
            twoCounter += 1
        }
    }
    
    var index   = 0
    var offset  = 0
    while index < zeroCounter {
        array[index] = 0
        index += 1
    }

    index   = 0
    offset  = zeroCounter
    while index < oneCounter {
        array[index + offset] = 1
        index += 1
    }
    index  = 0
    offset = zeroCounter + oneCounter
    while index < twoCounter {
        array[index + offset] = 2
        index += 1
    }
}


var array = [0, 1, 1, 0, 1, 2, 1, 2, 0, 0, 0, 1]
segregate012V2(&array)
print(array)

