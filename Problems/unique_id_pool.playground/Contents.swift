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

// Solution 3: Combine solution 1 and 2
// a. Divide the data segment in k-Segment
// b. Each segment is nothing but a range
// c. To assign:
//      a. Generator pick a segment randomly
//      b. Return one available id from that bucket: O(n/k)
// d. To release:
//      a. Find the segment from the id: O(1)
//      b. Release the id of that bucket: O(1)
// 1. That system give us concurrent system
// 2. Memory size could be low as you will only load n/k size
// 3. Serialization is possible to reduce runtime memory
// Problem: Still lot's of memory and Assign could be expensive for low k

// Solution 4: Use Binary Tree
// a. Consider you are storing only Integer as Id
// b. Each Int is 64 bit which mean each Int can hold 64 information
// c. Each leaf node hold a Int which is equivalent of 64 different id
// d. 100 mill mean 100, 000, 000 which mean O(lg n) = 25 is the height of the tree
//      1. This indicate we can reach to proper leaf in 25 call
//      2. Any data access is O(25) for 100 mill data
// e. Total item required =  100,000,000 / 64 = 1562500
// f. Total memory = (1562500 * 64) / 8 / 1024 / 1024 = 11.92 MB
// Psudo Code
//  a. Initialize the array with n / 64 number of elements
//  b. Initial value is 0 for all element
//  c. Keep counter to keep track how many issued
//  d. Use O(lg n) to assign or release

