// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

/**
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for (index, value) in nums.enumerated() {
        if let otherIndex = dict[target - value] {
            return [index, otherIndex]
        }
        dict[value] = index
    }
    
    return [-1, -1]
}
