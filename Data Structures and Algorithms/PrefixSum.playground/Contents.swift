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
 
/*
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
*/

/*
/// Given an array of integers nums, you start with an initial positive value startValue.
/// In each iteration, you calculate the step by step sum of startValue plus elements in nums (from left to right).
/// Return the minimum positive value of startValue such that the step by step sum is never less than 1.
func minStartValue(_ nums: [Int]) -> Int {
    var minValue = 0, curr = 0
    for num in nums {
        curr += num
        minValue = min(minValue, curr)
    }
    
    return abs(minValue) + 1
}
let nums = [-3,2,-3,4,2]
minStartValue(nums)
*/

/// You are given a 0-indexed array nums of n integers, and an integer k.
/// The k-radius average for a subarray of nums centered at some index i with the radius k is the average of all elements in nums between the indices i - k and i + k (inclusive). If there are less than k elements before or after the index i, then the k-radius average is -1.
/// Build and return an array avgs of length n where avgs[i] is the k-radius average for the subarray centered at index i.
/// The average of x elements is the sum of the x elements divided by x, using integer division. The integer division truncates toward zero, which means losing its fractional part.
func getAveragesWithPrefixSum(_ nums: [Int], _ k: Int) -> [Int] {
    let n = nums.count
    let windowSize = 2 * k + 1
    var avgs = [Int](repeating: -1, count: n)
    
    guard windowSize <= n else {
        return avgs
    }
    
    var prefix = [Int](repeating: 0, count: n + 1)
    for i in 0..<n {
        prefix[i + 1] = prefix[i] + nums[i]
    }
    
    for i in k..<(n - k) {
        let start = i - k
        let end = i + k
        let sum = prefix[end + 1] - prefix[start]
        avgs[i] = sum / windowSize
    }
    
    return avgs
}
let nums = [7,4,3,9,1,8,5,2,6], k = 3
getAveragesWithPrefixSum(nums, k)


func getAveragesWithSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    let n = nums.count
    let windowSize = 2 * k + 1
    
    var avgs = [Int](repeating: -1, count: n)
    
    guard windowSize <= n else {
        return avgs
    }
    
    var windowSum = nums[0..<windowSize].reduce(0, +)
    avgs[k] = windowSum / windowSize
    
    for i in (windowSize)..<n {
        windowSum += nums[i]
        windowSum -= nums[i - windowSize]
        
        let center = i - k
        avgs[center] = windowSum / windowSize
    }
    
    return avgs
}
getAveragesWithSlidingWindow(nums, k)
