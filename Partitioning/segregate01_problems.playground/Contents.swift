import Foundation


// You are given an array of 0s and 1s in random order. Segregate 0s on left side and 1s on right side of the array. Traverse array only once.

func segregate01V1(_ array: inout[Int]) {
    var low     = 0
    var high    = array.count - 1
    
    // array[0..low - 1]    = all values 0
    // array[low..high-1]   = all values unrestricted
    // array[high..N-1]     = all values 1
    
    while low < high {
        if array[low] == 0 {
            low += 1
        }else {
            array.swapAt(low, high)
            high -= 1
        }
    }
}

func segregate01V2(_ array: inout[Int]) {
    var zeroCounter = 0
    var oneCounter  = 0
    
    for item in array {
        if item == 0 {
            zeroCounter += 1
        } else {
            oneCounter += 1
        }
    }
    
    let count = array.count
    for index in 0..<zeroCounter {
        array[index] = 0
    }
    
    for index in zeroCounter..<count {
        array[index] = 1
    }
}


var array = [0, 1, 1, 0, 0]
segregate01V2(&array)
print(array)

