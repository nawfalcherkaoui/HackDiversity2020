import Foundation

class Node {
    var value: Int
    var next: Node?
    
    init(value: Int) {
        self.value = value
        next = nil
    }
}


class LinkedList {
    var head: Node?
    
    init() {
        head = nil
    }
}


// For testing purposes
extension LinkedList {
    // Time Complexity: O(N) where N is our size variable
    func appendToTail(value: Int) {
        let newNode = Node(value: value)
        
        if head == nil {
            head = newNode
            return
        }
        
        var currentNode = head
        
        // while the next node is not nil
        while currentNode?.next != nil {
            // then we want to move the next node by assigning currentNode to currentNode?.next
            currentNode = currentNode?.next
        }
        
        // after going through the whole linked list until the last element where (currentNode?.next == nil), then we set the new node
        currentNode?.next = newNode
        
    }
    
    func getNodeK(k: Int) -> Node? {
        if head == nil { return nil }
        
        var currentNode = head
        var counter = 1
        while counter < k {
            if currentNode == nil {
                return head
            }
            
            currentNode = currentNode?.next
            counter += 1
        }
        
        return currentNode
    }
}

// Static functions
extension LinkedList {
    public static func creatNewLinkedList(from values: Int...) -> LinkedList {
        let linkedList = LinkedList()
        for value in values {
            linkedList.appendToTail(value: value)
        }
        
        return linkedList
    }
    
    static func getLinkedListStringRepresentationFrom(_ head: Node) -> String {
        var currentNode: Node? = head
        var listStringDescription = ""
        // while the current node is not nil
        while currentNode != nil {
            listStringDescription += currentNode?.next != nil ? "\(currentNode!.value)  -> " : "\(currentNode!.value)"
            // then we want to move the next node by assigning currentNode to currentNode?.next
            currentNode = currentNode?.next
        }
        
        return listStringDescription
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var listStringDescription = ""
        var currentNode = head

        // while the current node is not nil
        while currentNode != nil {
            listStringDescription += currentNode?.next != nil ? "\(currentNode!.value)  -> " : "\(currentNode!.value)"
            // then we want to move the next node by assigning currentNode to currentNode?.next
            currentNode = currentNode?.next
        }

        return listStringDescription
    }
}


/*
   1) Remove Kth node in the linked list
    Time Complexity: O(K)
*/

func removeKthNode(head: Node?, k: Int) -> Node? {
    if head == nil { return nil }
    
    // if k is our first node
    if k == 1 {
        return head?.next
    }
    
    var currentNode = head
    // create a counter to loop through the linked list
    var counter = 1
    
    // now we keep looping to move the currentNode to the (k - 1) node
    while counter < (k - 1) {
        
        // we need to check if K is out of bounds?
        // for example: K could be 20 and our linkedList has only 5 nodes, then our currentNode will eventually be nil because k is bigger than the linkedList size
        if currentNode == nil {
            return head
        }
        
        currentNode = currentNode?.next
        counter += 1
    }
    
    // now we know that our current node is in the (k - 1) position in the linked list
    currentNode?.next = currentNode?.next?.next
    
    return head
}

// Tests

//if let head = removeKthNode(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 5) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNode(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 1) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNode(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 3) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNode(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 6) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}


/*
   2) Remove Kth node from the end of the linked list
    Time Complexity: O(N)
*/

func removeKthNodeFromEnd(head: Node?, k: Int) -> Node? {
    var slowRunner = head
    var fastRunner = head
    
    // we need tp move the fastRunner to the kth node
    var counter = 1
    while counter < (k + 1) {
        // just like we did in the previous problem
        // let's make sure K is not out of bounds by checking if fastRunner == nil
        if fastRunner == nil {
            return head
        }
        
        // move the fastRunner to the next node
        fastRunner = fastRunner?.next
        counter += 1
    }
    
    // in the case of the fastRunner is nil because k is the size of our linked list, then we will have delete the first node
    if fastRunner == nil {
        return slowRunner?.next
    }
    
    // Now we know that the fastRunner is (k+1) nodes away from the slowRunner, let's move the fastRunner and slowRunner one at time until the fastRunner reaches the end of the linked list
    while fastRunner?.next != nil {
        fastRunner = fastRunner?.next
        slowRunner = slowRunner?.next
    }
    
    slowRunner?.next = slowRunner?.next?.next
    
    return head
}

// Tests

//if let head = removeKthNodeFromEnd(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 3) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNodeFromEnd(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 1) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNodeFromEnd(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 4) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}
//
//if let head = removeKthNodeFromEnd(head: LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6).head, k: 6) {
//    LinkedList.getLinkedListStringRepresentationFrom(head)
//}

/*
   3) Sum Lists
    Time Complexity: O(N)
*/

func sumLists(_ linkedList1: Node?, _ linkedList2: Node?) -> LinkedList {
    
    let result = LinkedList()
    
    var head1 = linkedList1
    var head2 = linkedList2
    
    var carryOver = 0
    
    while head1 != nil || head2 != nil {
        
        var sum = carryOver
        
        if head1 != nil {
            sum += head1!.value
            head1 = head1!.next
        }
        
        if head2 != nil {
            sum += head2!.value
            head2 = head2!.next
        }
        
        // update the carryOver
        carryOver = sum > 9 ? 1 : 0
        
        result.appendToTail(value: sum % 10) // it will append the second digit of the number
        
    }
    
    return result
}


// Tests

//print(sumLists(LinkedList.creatNewLinkedList(from: 7, 1, 6).head, LinkedList.creatNewLinkedList(from: 5, 9, 2).head)) // 617 + 295 = 912
//
//print(sumLists(LinkedList.creatNewLinkedList(from: 7).head, LinkedList.creatNewLinkedList(from: 2).head)) // 7 + 2 = 9
//
//print(sumLists(LinkedList.creatNewLinkedList(from: 7).head, LinkedList.creatNewLinkedList(from: 7, 1).head)) // 7 + 17 = 24
//
//print(sumLists(LinkedList.creatNewLinkedList(from: 0, 9, 1).head, LinkedList.creatNewLinkedList(from: 0, 1).head)) // 190 + 10 = 200



/*
   4) Reverse Linked List
*/

func reverseLinkedList(_ head: Node?) -> Node? {
    // if there is only one node, we'll just return it
    if head?.next == nil { return head }
    
    var firstPointer: Node?
    var secondPointer: Node? = head
    
    while secondPointer != nil {
        let thirdPointer = secondPointer?.next
        
        // point the secondPointer to the firstPointer
        secondPointer?.next = firstPointer
        
        // move firstPointer to secondPointer
        firstPointer = secondPointer
        
        // move secondPointer to thirdPointer
        secondPointer = thirdPointer
    }
    
    return firstPointer
}



// Tests
//if let reversedLinkedListHead = reverseLinkedList(LinkedList.creatNewLinkedList(from: 5, 4, 3, 2, 1).head) {
//    LinkedList.getLinkedListStringRepresentationFrom(reversedLinkedListHead)
//}
//
//if let reversedLinkedListHead = reverseLinkedList(LinkedList.creatNewLinkedList(from: 1).head) {
//    LinkedList.getLinkedListStringRepresentationFrom(reversedLinkedListHead)
//}
//
//if let reversedLinkedListHead = reverseLinkedList(LinkedList.creatNewLinkedList(from: 20, 5, 99, 0).head) {
//    LinkedList.getLinkedListStringRepresentationFrom(reversedLinkedListHead)
//}


/*
   5) is Palindrome
*/

struct Stack<T> {
    var items: [T] = []
    
    mutating func pop() -> T {
        return items.removeLast()
    }
  
    mutating func push(_ element: T) {
        items.append(element)
    }
}

func isPalindrome(_ head: Node?) -> Bool {
    // if there is only one node, we'll just return it
    var slowRunner = head
    var fastRunner = head
    
    var stack = Stack<Int>()
    
    // we'll keep looping until the fast runner reaches the end
    while fastRunner != nil && fastRunner?.next != nil {
        stack.push(slowRunner!.value)
        fastRunner = fastRunner?.next?.next
        slowRunner = slowRunner?.next
    }
    
    // if fastRunner is not nil, then we know we have an odd list size
    if fastRunner != nil {
        slowRunner = slowRunner?.next
    }
    
    // let's traverse the slow runner all the way to the end and make sure all the values are equal
    while slowRunner != nil {
        let top = stack.pop()
        
        if top != slowRunner?.value {
            return false
        }
        
        slowRunner = slowRunner?.next
    }
    
    return true
}

//print(isPalindrome(LinkedList.creatNewLinkedList(from: 7, 1, 1, 7).head))
//print(isPalindrome(LinkedList.creatNewLinkedList(from: 7, 1, 6, 1, 7).head))
//
//print(isPalindrome(LinkedList.creatNewLinkedList(from: 1, 2, 3, 4).head))
//print(isPalindrome(LinkedList.creatNewLinkedList(from: 3, 4, 6).head))

/*
   6) Find a loop
*/

func findLoop(head: Node?) -> Node? {
    var slowRunner = head
    var fastRunner = head
    
    // we'll keep looping as long as the fast runner is not nil or we have a meeting node
    while fastRunner != nil && fastRunner?.next != nil {
        fastRunner = fastRunner?.next?.next
        slowRunner = slowRunner?.next
        
        if fastRunner === slowRunner {
            break;
        }
    }
    
    // if fastRunner is nil, then we know that the 2 pointers didn't meet and therefore no loop
    if fastRunner == nil || fastRunner?.next == nil {
        return nil
    }
    
    // move slowRunner to the begining of the list and let fastRunner at meeting node
    slowRunner = head
    
    // we'll move the slowRunner and fastRunner one at a time and eventually they'll meet at loop start
    while slowRunner !== fastRunner {
        fastRunner = fastRunner?.next
        slowRunner = slowRunner?.next
    }
    
    return fastRunner
}

//let linkedList1 = LinkedList.creatNewLinkedList(from: 1, 2, 3, 4, 5, 6)
//let lastHead = linkedList1.getNodeK(k: 6)
//let thirdHead =  linkedList1.getNodeK(k: 3)
//lastHead?.next = thirdHead
//
//if let loopNode = findLoop(head: linkedList1.head) {
//    print(loopNode === thirdHead)
//    print(loopNode.value)
//}
