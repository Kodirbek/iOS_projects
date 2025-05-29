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
/*
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
*/

/**
 Given a string sentence containing only lowercase English letters, return true if sentence is a pangram, or false otherwise.
 */
/*
func isPangram(_ sentence: String) -> Bool {
    let letters = Set(sentence)
    return letters.count == 26
}

// bitmap solution
func isPangram2(_ sentence: String) -> Bool {
    var seen = 0
    
    for char in sentence {
        let ascii = Int(char.asciiValue! - Character("a").asciiValue!)
        seen |= (1 << ascii)
    }
    
    return seen == (1 << 26) - 1
}
*/

/**
 Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.
 For example, Input:  nums = [3,0,1], Output: 2
 Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
 */
/*
 // Complexity: Space: O(n), time: O(n)
func missingNumber(_ nums: [Int]) -> Int {
    let numsFullSet = Set((0...nums.count))
    let numsSet = Set(nums)
    return numsFullSet.subtracting(numsSet).first!
}

// Complexity: Space: O(1), time: O(n)
func missingNumber2(_ nums: [Int]) -> Int {
    let n = nums.count
    let expectedSum = (n * (n + 1)) / 2
    let actualSum = nums.reduce(0, +)
    return expectedSum - actualSum
}
let nums: [Int] = [3,0,1]
missingNumber2(nums)
 */

/**
 Given an integer array arr, count how many elements x there are, such that x + 1 is also in arr. If there are duplicates in arr, count them separately.
 Input: arr = [1,2,3]
 Output: 2
 Explanation: 1 and 2 are cou
 */
/*
func countElements(_ arr: [Int]) -> Int {
    var count = 0
    let set = Set(arr)
    for num in arr {
        if set.contains(num + 1) {
            count += 1
        }
    }
    return count
}
let num1: [Int] = [1,1,2,2]
countElements(num1)
*/

/**
 Example 1: You are given a string s and an integer k. Find the length of the longest substring that contains at most k distinct characters.
 For example, given s = "eceba" and k = 2, return 3. The longest substring with at most 2 distinct characters is "ece".
 */
func longestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
    var counts: [Character: Int] = [:]
    var left = 0, answer = 0
    for (index, character) in s.enumerated() {
        counts[character, default: 0] += 1
        while counts.count > k {
            counts[character]! -= 1
            if counts[character] == 0 {
                counts.removeValue(forKey: character)
            }
            left += 1
        }
        
        answer = max(answer, index - left + 1)
    }
    
    return answer
}
let s = "eceba", k = 2
longestSubstringKDistinct(s, k)
