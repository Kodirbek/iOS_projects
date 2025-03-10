// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

// MARK: Two pointers

/*
/// 1. Example 1: Given a string s, return true if it is a palindrome, false otherwise.
func isPalindrome(_ word: String) -> Bool {
    var left = word.startIndex
    var right = word.index(before: word.endIndex)
    
    while left < right {
        if word[left] != word[right] {
            return false
        }
        left = word.index(after: left)
        right = word.index(before: right)
    }
    
    return true
}

isPalindrome("abba")
*/


/*
/// Example 2: Given a sorted array of unique integers and a target integer, return true if there exists a pair of numbers that sum to target, false otherwise. This problem is similar to Two Sum. (In Two Sum, the input is not sorted).
/// For example, given nums = [1, 2, 4, 6, 8, 9, 14, 15] and target = 13, return true because 4 + 9 = 13.
func checkSum(_ nums: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = nums.count - 1
    
    while left < right {
        let sum = nums[left] + nums[right]
        
        if sum == target {
            return true
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return false
}

checkSum( [1, 2, 4, 6, 8, 9, 14, 15], 13)
 */


/*
/// Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.
/// Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var left = 0
    var right = numbers.count - 1
    
    while left < right {
        let sum = numbers[left] + numbers[right]
        
        if sum == target {
            return [left + 1, right + 1]
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return []
}

twoSum( [2, 7, 11, 15], 9)
twoSum( [2, 3, 4], 6)
twoSum( [-1, 0], -1)
 */


/*
/// Example 3: Given two sorted integer arrays arr1 and arr2, return a new array that combines both of them and is also sorted.
func combineSortedArrays(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    var result = [Int]()
    var index1 = 0
    var index2 = 0
    
    while index1 < arr1.count && index2 < arr2.count {
        if arr1[index1] < arr2[index2] {
            result.append(arr1[index1])
            index1 += 1
        } else {
            result.append(arr2[index2])
            index2 += 1
        }
    }
    
    while index1 < arr1.count {
        result.append(arr1[index1])
        index1 += 1
    }
    
    while index2 < arr2.count {
        result.append(arr2[index2])
        index2 += 1
    }
    
    return result
}

combineSortedArrays( [1, 3, 5, 7], [2, 4, 6, 8])
*/


/// Example 4: 392. Is Subsequence.
/// Given two strings s and t, return true if s is a subsequence of t, or false otherwise.
/*
func isSubsequent(_ s: String, _ t: String) -> Bool {
    guard !s.isEmpty else {
        return true
    }
    
    var i = s.startIndex
    var j = t.startIndex
    while i != s.endIndex && j != t.endIndex {
        if s[i] == t[j] {
            i = s.index(after: i)
        }
        
        j = t.index(after: j)
    }
    
    return i == s.endIndex
}

isSubsequent("abc", "ahbgdc")
*/

func reverseString(_ s: inout [Character]) {
    var left = 0
    var right = s.count - 1
    
    while left < right {
        // classic swap
//        var char1 = s[left]
//        s[left] = s[right]
//        s[right] = char1
        
        // tuple swap
        (s[left], s[right]) = (s[right], s[left])
        
        left += 1
        right -= 1
    }
}

var s: [Character] = ["H","a","n","n","a","h"]
reverseString(&s)
