// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

// MARK: Prefix Sum

/*
/// Example 1: Given an integer array nums, an array queries where queries[i] = [x, y] and an integer limit, return a boolean array that represents the answer to each query. A query is true if the sum of the subarray from x to y is less than limit, or false otherwise.
/// For example, given nums = [1, 6, 3, 2, 7, 2], queries = [[0, 3], [2, 5], [2, 4]], and limit = 13, the answer is [true, false, true]. For each query, the subarray sums are [12, 14, 12].
func answerQueries(_ nums: [Int], _ queries: [[Int]], _ limit: Int) -> [Bool] {
    var prefix = [nums[0]]
    for i in 1..<nums.count {
        prefix.append(nums[i] + prefix[i-1])
    }
    
    var answer: [Bool] = []
    for query in queries {
        let x = query[0], y = query[1]
        let current = prefix[y] - prefix[x] + nums[x]
        answer.append(current < limit)
    }
    
    return answer
}

let nums = [1, 6, 3, 2, 7, 2], queries = [[0, 3], [2, 5], [2, 4]], limit = 13
answerQueries(nums, queries, limit)
*/

/*
 /// Example 2: 2270. Number of Ways to Split Array
 /// Given an integer array nums, find the number of ways to split the array into two parts so that the first section has a sum greater than or equal to the sum of the second section. The second section should have at least one number.
 func waysToSplitArray(_ nums: [Int]) -> Int {
 let n = nums.count - 1
 var prefix = [nums[0]]
 for i in 1..<nums.count {
 prefix.append(nums[i] + prefix[i-1])
 }
 
 var answer = 0
 for i in 0..<n {
 let left = prefix[i], right = prefix[n] - left
 if left >= right {
 answer += 1
 }
 }
 
 return answer
 }
 let nums = [10, 4, -8, 7]
 waysToSplitArray(nums)
 */
 
/// More space efficient version of waysToSplitArray: waysToSplitArray2.
/// Improvement point: Space complexity is O(1) compared to O(n) in waysToSplitArray as there is no need to create prefixSum array.
/// On Leetcode: Runtime: Beats 100%, Memory: Beats 84.6%
func waysToSplitArray2(_ nums: [Int]) -> Int {
    let count = nums.count
    let totalSum = nums.reduce(0, +)
    
    var answer = 0, leftSum = 0
    
    for i in 0..<(count - 1) {
        leftSum += nums[i]
        let rightSum = totalSum - leftSum
        
        if leftSum >= rightSum {
            answer += 1
        }
    }
    
    return answer
}
let nums = [10, 4, -8, 7]
waysToSplitArray2(nums)
