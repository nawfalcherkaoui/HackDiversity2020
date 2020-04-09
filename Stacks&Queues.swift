import Foundation

class Node<T> {
    var value: T
    var next: Node?

    init(value: T) {
        self.value = value
        next = nil
    }
}

struct MinMax<T> {
    var min: T
    var max: T
}


class Stack<T: Comparable> {

    var top: Node<T>? = nil
    var minMax = [MinMax<T>]()

    func peek() -> T? {
        return top != nil ? top?.value : nil
    }

    func pop() -> T? {
        if top == nil { return nil }
        
        // min max
        minMax.popLast()

        // stack
        let value = top?.value
        top = top?.next

        return value
    }

    func push(_ value: T) {
        var newMinMax = MinMax(min: value, max: value)

        if let minMax = self.minMax.last {
            newMinMax = MinMax(
                min: min(value, minMax.min),
                max: max(value, minMax.max)
            )
        }

        self.minMax.append(newMinMax)
        
        // stack
        let newNode = Node(value: value)
        newNode.next = top
        top = newNode
    }

    func getMin() -> T? {
        return minMax.last?.min
    }

    func getMax() -> T? {
        return minMax.last?.max
    }
    
    func isEmpty() -> Bool {
        return top == nil
    }
}

var minMaxStack = Stack<Int>()
minMaxStack.push(5)
minMaxStack.getMax()
minMaxStack.getMin()
minMaxStack.push(2)
minMaxStack.getMax()
minMaxStack.getMin()
minMaxStack.push(20)
minMaxStack.getMax()
minMaxStack.getMin()
minMaxStack.peek()
minMaxStack.pop()
minMaxStack.getMax()
minMaxStack.getMin()

/*
 2) Queue Implementation
 
*/

class Queue<T> {
    
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    
    public func enqueue(_ value: T) {
        let newNode = Node(value: value)
        
        // handling the special case when the queue isEmpty
        if isEmpty() {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }
    
    public func dequeue() -> T? {
        if isEmpty() {
            return nil
        }
        
        let value = head?.value
        head = head?.next
        
        if head == nil {
            tail = nil
        }
        
        return value
    }
    
    public func peek() -> T? {
        return head != nil ? head?.value : nil
    }
    
    public func isEmpty() -> Bool {
        return head == nil && tail == nil
    }
}


var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
queue.enqueue(5)
queue.peek()
queue.dequeue()
queue.peek()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()


/*
 3. Balanced Brackets
 */

func balancedBrackets(string: String) -> Bool {
    let stack = Stack<Character>()
    let oppeningBrackets = "([{"
    let matchingBrackets : [Character: Character] = [
        ")": "(",
        "]": "[",
        "}": "{"
    ]
    
    for char in string {
        if oppeningBrackets.contains(char) {
            stack.push(char)
        } else {
            let top = stack.pop()
            if top != matchingBrackets[char] {
               return false
            }
        }
    }
    
    return stack.isEmpty()
}

balancedBrackets(string: ")[]}")
balancedBrackets(string: "((({})()))")
balancedBrackets(string: "(()())((()()()))")



/*
 4) Sort Stack
*/

func sort(stack: inout Stack<Int>) {
    let sortedStack = Stack<Int>()
    
    while !stack.isEmpty() {
        let tempValue = stack.pop()!
        while !sortedStack.isEmpty(), sortedStack.peek()! > tempValue {
            stack.push(sortedStack.pop()!)
        }
        
        sortedStack.push(tempValue)
    }
    
    while !sortedStack.isEmpty() {
        stack.push(sortedStack.pop()!)
    }
}

var stack = Stack<Int>()
stack.push(-1)
stack.push(3)
stack.push(5)
stack.push(20)
stack.push(0)

sort(stack: &stack)

stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()


/*
 5) Maximum sum of a contiguous subarray pf size 3
 */

func maximumSum(array: [Int]) -> Int {
    if array.count < 3 { return 0 }
    var maximumSum = array[0] + array[1] + array[2]
    
    var index = 1
    while index < array.count - 2 {
        let currentSum = array[index] + array[index + 1] + array[index + 2]
        
        if maximumSum < currentSum {
            maximumSum = currentSum
        }
        
        index += 1
    }
    
    return maximumSum
}

maximumSum(array: [4, 2, 1, 7, 8, 1, 2, 8, 1, 0])
maximumSum(array: [4, 2, 1, 7, 8, 9, 9, 9, 1, 0])
maximumSum(array: [10, 0, 20, 11, 4, 90, 5])
