// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

// MARK: Sliding Window

/*
/// Find the length of the longest subarray in [3, 2, 1, 3, 1, 1] that has a sum less than or equal to 5.
func longestSubarraySumLessThanOrEqualTo(_ arr: [Int], _ target: Int) -> Int {
    var (left, curr, answer) = (0, 0, 0)
    for (right, value) in arr.enumerated() {
        curr += value
        while curr > target {
            curr -= arr[left]
            left += 1
        }
        answer = max(answer, right - left + 1)
    }
    
    return answer
}


let nums = [3, 2, 1, 3, 1, 1]
longestSubarraySumLessThanOrEqualTo(nums, 5)
*/
 
/*
/// You are given a binary string s (a string containing only "0" and "1"). You may choose up to one "0" and flip it to a "1". What is the length of the longest substring achievable that contains only "1"?
func findLongestBinary(s: String) -> Int {
    var left = s.startIndex
    var (leftOffset, curr, answer) = (0, 0, 0)
    
    for (index, char) in s.enumerated() {
        if char == "0" {
            curr += 1
        }
        
        while curr > 1 {
            if s[left] == "0" {
                curr -= 1
            }
            left = s.index(after: left)
            leftOffset += 1
        }
        
        answer = max(answer, index - leftOffset + 1)
    }
    
    return answer
}

let s = "1101100111"
findLongestBinary(s: s)
*/

/*
/// Given an array of positive integers nums and an integer k, return the number of subarrays where the product of all the elements in the subarray is strictly less than k
/// For example, given the input nums = [10, 5, 2, 6], k = 100, the answer is 8. The subarrays with products less than k are:
/// [10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6]
func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
    if k <= 1 {
        return 0
    }
    
    var (answer, left, current) = (0, 0, 1)
    for (right, value) in nums.enumerated() {
        current *= value
        while current >= k {
            current /= nums[left]
            left += 1
        }
        answer += right - left + 1
    }
    
    return answer
}
let nums = [10, 5, 2, 6], k = 100
numSubarrayProductLessThanK(nums, k)
*/


/// Example 4: Given an integer array nums and an integer k, find the sum of the subarray with the largest sum whose length is k.
func findBestSubarraySum(_ nums: [Int], _ k: Int) -> Int? {
    guard k > 0, k <= nums.count else {
        return nil
    }
    
    var currentSum = nums[0..<k].reduce(0, +)
    var bestSum = currentSum
    
    for i in k..<nums.count {
        currentSum += nums[i] - nums[i - k]
        bestSum = max(bestSum, currentSum)
    }
    
    return bestSum
}
let nums = [3, -1, 4, 12, -8, 5, 6], k = 4
findBestSubarraySum(nums, k)


