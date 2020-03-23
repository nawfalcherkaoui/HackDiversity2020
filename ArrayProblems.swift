import Foundation

// Helpers
func swap(_ i: Int, _ j: Int, _ array: inout [Int]) {
    let temp = array[i]
    array[i] = array[j]
    array[j] = temp
}

/*
    1) Implement an algorithm to determine if an Array has all unique Integers?
 */

func isUnique(array: inout [Int]) -> Bool {

    array.sort()

    var index = 0
    while index < array.count - 1 {
        if array[index] == array[index + 1] {
            return false
        }
        index += 1
    }

    return true
}

// Tests
//var array1 = [1]
//isUnique(array: &array1)
//
//var array2 = [1, 2, 3, 4, 5]
//isUnique(array: &array2)
//
//var array3 = [2, 3, 4, 4, 5]
//isUnique(array: &array3)
//
//var array4 = [2, 2]
//isUnique(array: &array4)
//
//var array5 = [22, 34, 45, 59]
//isUnique(array: &array5)


/*
   2) Given two arrays of integers, decide if one is a permutation of the other?
    O(NlogN)
*/

func isPermutation(array1: inout [Int], array2: inout [Int]) -> Bool {

    if array1.count != array2.count { return false }

    array1.sort()
    array2.sort()

    var array1Pointer = 0

    while array1Pointer < array1.count {
        if array1[array1Pointer] != array2[array1Pointer] {
            return false
        }
        array1Pointer += 1
    }

    return true
}


// 2nd solution using a dictionary that runs in O(n)
func isPermutation2(array1: inout [Int], array2: inout [Int]) -> Bool {

    if array1.count != array2.count { return false }
    
    var dict = [Int: Int]()

    for number in array1 {
        if let numberFrequency = dict[number] {
            dict[number] = numberFrequency + 1
        } else {
            dict[number] = 1
        }
    }
    
    for number in array2 {
        if let numberFrequency = dict[number], numberFrequency > 0 {
            dict[number] = numberFrequency - 1
        } else {
            return false
        }
    }

    return true
}

// Tests

//var array1 = [1, 2, 3]
//var array2 = [1, 3, 2]
//isPermutation(array1: &array1, array2: &array2)
//
//var array3 = [1, 2, 3]
//var array4 = [1, 2]
//isPermutation(array1: &array3, array2: &array4)
//
//var array5 = [1, 4, 3]
//var array6 = [1, 2, 3]
//isPermutation(array1: &array5, array2: &array6)
//
//var array7 = [5, 6, 7, 8, 9]
//var array8 = [9, 5, 8, 6, 7]
//isPermutation(array1: &array7, array2: &array8)
//
//var array9 = [1]
//var array10 = [1]
//isPermutation(array1: &array9, array2: &array10)



/*
    3) Merge two sorted arrays
    O(a + b) where a is the length of array1 and b is the length of array2
 */
func merge(_ array1: [Int], _ array2: [Int]) -> [Int] {
    
    var result = [Int]()
    
    var left = 0
    var right = 0
    
    while left < array1.count && right < array2.count {
        let leftNumber = array1[left]
        let rightNumber = array2[right]
        
        if leftNumber <= rightNumber {
            result.append(leftNumber)
            left += 1
        } else {
            result.append(rightNumber)
            right += 1
        }
    }
    
    // Store remaining elements of first array
    while left < array1.count {
        result.append(array1[left])
        left += 1
    }
    
    // Store remaining elements of second array
    while right < array2.count {
        result.append(array2[right])
        right += 1
    }
    
    return result
}

// Tests

//merge([1, 2, 3], [2, 5, 6])
//merge([-1, 2, 7], [-4, 0, 2, 6])
//merge([5, 8, 9], [4, 7, 8])
//merge([1, 2, 3], [-1])



/*
    4) Two Number Sum
    O(NlogN)
 */

func twoNumberSum(array: inout [Int], targetSum: Int) -> [Int] {
    
    array.sort()
    
    var left = 0
    var right = array.count - 1
    
    while left < right {
        let sum = array[left] + array[right]
        if sum == targetSum {
            return [array[left], array[right]]
        } else if sum < targetSum {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return []
}


// Tests
//var array1 = [3, 4, -4, 8, 11, 1, -1, 6]
//let sum1 = 10
//twoNumberSum(array: &array1, targetSum: sum1)
////
//var array2 = [1, 2, 3, 4, 5, 6]
//let sum2 = 11
//twoNumberSum(array: &array2, targetSum: sum2)
////
//var array3 = [-2, 3, 0, 4, 5]
//let sum3 = 3
//twoNumberSum(array: &array3, targetSum: sum3)
//
//let sum4 = 100
//twoNumberSum(array: &array3, targetSum: sum4)




/*
   5) Move Element To End
    O(N)
*/

func moveElementToEnd(_ array: inout [Int], _ toMove: Int) -> [Int] {
    // Write your code here.
        var left = 0
        var right = array.count - 1
        
            while left < right {
                if array[right] == toMove {
                    right -= 1
                } else if array[left] != toMove {
                    left += 1
                } else {
                    // in this case left equals toMove and right doesn't equal to move
                    swap(left, right, &array)
                    left += 1
                    right -= 1
                }
            }
    
    return array
}


/*
   6) Largest Range
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
   1) ZigZag Traverse
    O(N)
*/

func zigZagTraverse(array: [[Int]]) -> [Int] {
    // Write your code here.
        var result = [Int]()
    
        var row = 0
        var col = 0
    
        let numberOfRows = array.count
        let numberOfCol = array[0].count
        var move: Move = .down
    
        while row < numberOfRows && col < numberOfCol {
            result.append(array[row][col])
            
            if move == .up {
             if isRightWall(col, numberOfCol) {
                    moveDown(&row)
                    move = .down
                } else if isTopWall(row) {
                    moveRight(&col)
                    move = .down
                } else {
                     zigzagUp(&row, &col)
                }
            } else if move == .down {
                 if isBottomWall(row, numberOfRows) {
                    moveRight(&col)
                    move = .up
                } else if isLeftWall(col) {
                    moveDown(&row)
                    move = .up
                } else {
                    zigzagDown(&row, &col)
                }
            }
        }
    
    return result
}


enum Move {
    case down
    case up
}

// You can only go down to leftWall and bottomWall
func isLeftWall(_ col: Int) -> Bool {
    return col == 0
}

func isBottomWall(_ row: Int, _ numberOfRows: Int) -> Bool {
    return row == numberOfRows - 1
}

// You can only go up to the rightWall and topWall
func isRightWall(_ col: Int, _ numberOfCol: Int) -> Bool {
    return col == numberOfCol - 1
}

func isTopWall(_ row: Int) -> Bool {
    return row == 0
}

func zigzagDown(_ row: inout Int, _ col: inout Int) {
    row += 1
    col -= 1
}

func zigzagUp(_ row: inout Int, _ col: inout Int) {
    row -= 1
    col += 1
}

func moveDown(_ row: inout Int) {
    row += 1
}

func moveRight(_ col: inout Int) {
    col += 1
}

// Tests
//let test1 =
//[
//  [1, 0, 5, -1, 8],
//  [2, -4, 2, 9, 10]
//]
//zigZagTraverse(array: test1)
//
//let test2 =
//    [
//      [1, 3, 4, 10],
//      [2, 5, 9, 11],
//      [6, 8, 12, 15],
//      [7, 13, 14, 16]
//    ]
//zigZagTraverse(array: test2)
