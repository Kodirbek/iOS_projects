// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

/**
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 */

/*
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
*/

/**
 Given a string s consisting of lowercase English letters, return the first letter to appear twice.
 Note:
    - A letter a appears twice before another letter b if the second occurrence of a is before the second occurrence of b.
    - s will contain at least one letter that appears twice.
 */
/*
func repeatedCharacter(_ s: String) -> Character {
    var seen: Set<Character> = []
    
    for char in s {
        if seen.contains(char) {
            return char
        }
        seen.insert(char)
    }
    
    return " "
}
*/

/**
 Given an integer array nums, find all the numbers x in nums that satisfy the following: x + 1 is not in nums, and x - 1 is not in nums.
 If a valid number x appears multiple times, you only need to include it in the answer once.
 */
func findNumbers(_ nums: [Int]) -> [Int] {
    var result: [Int] = []
    var setNums: Set<Int> = Set(nums)
    
    for num in setNums {
        if !setNums.contains(num - 1) && !setNums.contains(num + 1) {
            result.append(num)
        }
    }
    
    return result
}
