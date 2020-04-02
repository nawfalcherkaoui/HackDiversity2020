import Foundation

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
}


/*
 1) Word Frequency

*/

func setupDictionary(_ book: [String]) -> [String: Int] {
    var dict = [String: Int]()
    
    for word in book {
        if let frequencyCount = dict[word] {
            dict[word] = frequencyCount + 1
        } else {
           dict[word] = 1
        }
    }
    return dict
}

func getFrequency(_ wordsFrequency: [String: Int], _ word: String) -> Int {
    
    return wordsFrequency[word] ?? 0
}

let dictionary = setupDictionary(["maghrébin", "always", "code", "as", "if", "the", "maghrébin", "who", "ends", "up", "maintaining", "your", "code", "will", "be", "a", "violent", "psychopath", "who", "knows", "where", "you", "live", "maghrébin", "maghrébin", "maghrébin"])

getFrequency(dictionary, "maghrébin")
getFrequency(dictionary, "code")
getFrequency(dictionary, "who")
getFrequency(dictionary, "a")


//One of my most productive days was throwing away 1000 lines of code

/*
  2) Permutation
     O(N)
*/

func isPermutation(_ s: String, _ t: String) -> Bool {
    if s.count != t.count { return false }
    var dict = [Character: Int]()
    
    for char in s {
        if let frequencyCount = dict[char] {
            dict[char] = frequencyCount + 1
        } else {
           dict[char] = 1
        }
    }

    for char in t {
        if let frequencyCount = dict[char], frequencyCount > 0 {
            dict[char] = frequencyCount - 1
        } else {
           return false
        }
    }
    
    return true
}


isPermutation("anagram", "nagaram")


/*
 3) Palindrome Permutation
    O(N)
*/

func isPermutationOfPalindrome(phrase: String) -> Bool {
    
    var dict = [Character: Int]()
    
    let formattedPhrase = phrase.replacingOccurrences(of: " ", with: "").lowercased()
    
    // construct our hashTable with all the characters and their frequencies
    for char in formattedPhrase {
        if let frequencyCount = dict[char] {
            dict[char] = frequencyCount + 1
        } else {
            dict[char] = 1
        }
    }
    
    var foundOdd = false
    
    for (_, count) in dict {
        // if the count is odd
        if count % 2 == 1 {
            // if we already found and Odd count and this is the second time we come across it
            if foundOdd {
                return false
            }
            foundOdd = true
        }
    }
    
    return true
}

isPermutationOfPalindrome(phrase: "Tact Coa")
isPermutationOfPalindrome(phrase: "Tact Co")
isPermutationOfPalindrome(phrase: "Madam")
isPermutationOfPalindrome(phrase: "abba")



/*
 4) Intersection of Two Arrays
 O(N)
*/

func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var result = [Int]()
    
    var dict = [Int: Int]()

    for number in nums1 {
        if let numberFrequency = dict[number] {
            dict[number] = numberFrequency + 1
        } else {
           dict[number] = 1
        }
    }

    for number in nums2 {
        if let numberFrequency = dict[number], numberFrequency > 0 {
            result.append(number)
            dict[number] = numberFrequency - 1
        }
    }

    return result
}

//intersect([1, 2, 2, 1], [2, 2])
//intersect([4, 9, 5], [9, 4, 9, 8, 4])
//intersect([4, 9, 5], [2, 3, 5])
//intersect([1, 2, 3], [4, 5, 6])


/*
   5) Largest Range
    O(N)
*/

func largestRange(array: [Int]) -> [Int] {
    
    var dict = [Int: Bool]()
    
    var result = [Int]()
    
    var longestRange = 0
    
    
    for number in array {
        dict[number] = false
    }
    
    // for every number we're going to explore its range on the left side as well as the right side
    for number in array {
        // if a number has already been seen or was already part of a range, let's skip it
        if dict[number] == true { continue }
        
        var currentRange = 1
        
        // explore the range on left side
        var leftNumber = number - 1
        while dict[leftNumber] != nil {
            dict[leftNumber] = true // Mark it as seen
            currentRange += 1
            leftNumber -= 1
        }
        
        // explore the range on right side
        var rightNumber = number + 1
        while dict[rightNumber] != nil {
            dict[rightNumber] = true
            currentRange += 1
            rightNumber += 1
        }
        
        let min = leftNumber + 1
        let max = rightNumber - 1
        
        if currentRange > longestRange {
            result = [min, max]
            longestRange = currentRange
        }
    }
    
    return result
}

// Test
//largestRange(array: [1, 11, 3, 0, 15, 5, 2, 4, 10, 7, 12, 6])
//largestRange(array: [4, 2, 1, 3, 6])
//largestRange(array: [-1, 20, 6, 0, 4, 1, 8, 2])



/*
   6) longest Substring Without Duplication
    O(N)
*/

func longestSubstringWithoutDuplication(_ string: String) -> String {
    
    var lastSeenDict = [Character: Int]()
    var longestSubstring = ""
    var currentSubstring = ""
    
    var startingIndexSubstring = 0
    
    for (index, char) in string.enumerated() {
        if let lastSeenIndex = lastSeenDict[char], lastSeenIndex >= startingIndexSubstring {
            // we've already seen it
            
            // we need to update our starting index of the substring to be the next element after the duplicate
            startingIndexSubstring = lastSeenIndex + 1
            
            // update our current substring to get rid off the duplicate
            currentSubstring = string[startingIndexSubstring ..< index + 1]
            
            // update when we last seen the the char
            lastSeenDict[char] = index
        } else {
            // we've never seen it
            lastSeenDict[char] = index
            currentSubstring += "\(char)"
        }
        
        if currentSubstring.count > longestSubstring.count {
            longestSubstring = currentSubstring
        }
    }
    
    return longestSubstring
}

longestSubstringWithoutDuplication("maghrébin")
longestSubstringWithoutDuplication("hackdiversity")
longestSubstringWithoutDuplication("abcbde")
longestSubstringWithoutDuplication("a")
