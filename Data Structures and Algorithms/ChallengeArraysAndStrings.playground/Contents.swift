// LeetCode's Interview Crash Course
// Data Structures and Algorithms

import UIKit

/// Given a string s, reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.
/// Input: s = "Let's take LeetCode contest"
/// Output: "s'teL ekat edoCteeL tsetnoc"
/*
func reverseWords(_ s: String) -> String {
    var chars = Array(s)
    let n = chars.count
    
    var start = 0
    for i in 0...n {
        if i == n || chars[i] == " " {
            var left = start
            var right = i - 1
            while left < right {
                chars.swapAt(left, right)
                left += 1
                right -= 1
            }
            start = i + 1
        }
    }
    
    return String(chars)
}
let s = "Let's take LeetCode contest"
reverseWords(s)
*/

/// Given a string s, reverse the string according to the following rules:
/// All the characters that are not English letters remain in the same position.
/// All the English letters (lowercase or uppercase) should be reversed.
/// - Parameter s: the array of strings to be reversed
/// - Returns: reversed s
///   - example:  s = "Test1ng-Leet=code-Q!" returns "Qedo1ct-eeLg=ntse-T!"
func reverseOnlyLetters(_ s: String) -> String {
    var chars = Array(s)
    var left = 0
    var right = chars.count - 1
    
    while left < right {
        while left < right && !(chars[left]).isLetter {
            left += 1
        }
        
        while left < right && !(chars[right]).isLetter {
            right -= 1
        }
        
        chars.swapAt(left, right)
        
        left += 1
        right -= 1
    }
    
    
    return String(chars)
}
let s = "Test1ng-Leet=code-Q!"
reverseOnlyLetters(s)
