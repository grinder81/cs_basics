import UIKit

/**
 Implement two functions that assign/release unique id's from a pool.
 Memory usage should be minimized and the assign/release should be fast,
 even under high contention. alloc() returns available ID release(id)
 releases previously assigned ID
*/

// Solution 1: Using Dictionary
//  a. Keep a set to maintain all unique id
//  b. To assign
//      1. Loop through the set
//      2. If an item is true then
//      3. Mark it false and return the id
//  c. To release
//      1. Find the value by the return key
//      2. Mark it as true which mean available

// Solution 2: Using Array
//  a. Create array with size of max number of elements
//  b. Default value should be true which mean available
//  c. To assign just return from the index and mark it false
//  d. To releas just mark element at index to true

// None of the above good for memory or concurency
// What if we use Binary Tree system? Let's say we divide the
// data in n/2 and left child will contain 0 to n/2 and
// right child will contain n/2 + 1 to n-1. In this way
// we can divide the data in 2 part which can work completly
// concurently. We can reach to leaf bucket which O(lg n) and
// then use array to find item for assign or release

