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
