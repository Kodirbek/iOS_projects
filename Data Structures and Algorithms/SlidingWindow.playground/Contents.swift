// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

// MARK: Sliding Window

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
