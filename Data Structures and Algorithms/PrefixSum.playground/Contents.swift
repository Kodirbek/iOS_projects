// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

// MARK: Prefix Sum

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
