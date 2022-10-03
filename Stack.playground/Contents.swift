import UIKit

var array1 = [2,9,0,6,8,10]
var array2 = ["(","(","a","+","b",")","(","c","+","d",")",")"]
var array3 = ["(","(","(","a","+","b",")","(","c","+","d",")",")"]
var array4 = ["a","+","b","*","c","-","d","/","e"]

public class StackUsingAray<T> {
    
    var size: Int
    var top: Int
    var element: [T?]
    
    public init(_ size: Int) {
        self.size = size
        self.top = -1
        self.element = Array(repeating: nil, count: size)
    }
    
    public var isEmpty: Bool {
        return self.top == -1 ? true : false
    }
    
    public var isFull: Bool {
        return self.top + 1 == self.size ? true : false
    }
    
    public var stackTop: T? {
        guard !isEmpty else { return nil }
        return self.element[self.top]
    }
    
    public func display() {
        guard !isEmpty else { return }
        var index = self.top
        while (index >= 0) {
            print(self.element[index] as Any, terminator : "  ")
            index -= 1
        }
    }
    
    public func push(_ value: T) {
        guard !isFull else { return }
        self.top += 1
        self.element[self.top] = value
    }
    
    public func pop() {
        guard !isEmpty else { return }
        self.top -= 1
    }
    
    public func peek(_ pos: Int) -> T? {
        guard !isEmpty && pos < self.size - 1 else { return -1 as? T }
        return self.element[pos]
    }
}

/* Create and fetch stack using array */

func createAndFetchStackUsingArray(array: [Any]) -> StackUsingAray<Any> {
    var firstIndex = 0
    let lastIndex = array.count
    let stack = StackUsingAray<Any>(lastIndex)
    while (firstIndex < lastIndex) {
        stack.push(array[firstIndex])
        firstIndex += 1
    }
    return stack
}

//let stack1 = createAndFetchStackUsingArray(array: array1)
//print(stack1.stackTop as Any)
//print(stack1.isEmpty)
//print(stack1.isFull)
//print(stack1.display())
//print("POP", stack1.pop(), stack1.display())
//print("Peek", stack1.peek(4) as Any)

public class StackListNode<T>  {

    public var data: T
    public var next: StackListNode?

    public init(data: T, next: StackListNode? = nil) {
        self.data = data
        self.next = next
    }
}

public class StackUsingList<T> {
    
    var top: StackListNode<T>?
    var size: Int
    
    public init() {
        self.top = nil
        self.size = 0
    }
    
    public var isEmpty: Bool {
        return self.size == 0 ? true : false
    }
    
    public var stackTop: T? {
        guard !isEmpty else { return -1 as? T }
        return self.top?.data
    }
    
    public func display() {
        guard !isEmpty else { return }
        var stackNode = self.top
        while(stackNode != nil) {
            print(stackNode?.data as Any, terminator : "  ")
            stackNode = stackNode?.next
        }
    }
    
    public func push(_ value: T) {
        self.top = StackListNode(data: value, next: self.top)
        self.size += 1
    }
    
    public func pop() {
        guard !isEmpty else { return }
        self.top = self.top?.next
        self.size -= 1
    }
    
    public func peek(_ pos: Int) -> T? {
        guard !isEmpty else { return nil }
        var node = self.top
        var firstindex = 0
        while (node != nil && firstindex < pos - 1) {
            node = node?.next
            firstindex += 1
        }
        return node != nil ? node?.data : -1 as? T
    }
}

/* Create and fetch stack using list */

func createAndFetchStackUsingList(array: [Any]) -> StackUsingList<Any> {
    var firstIndex = 0
    let lastIndex = array.count
    let stack = StackUsingList<Any>()
    while (firstIndex < lastIndex) {
        stack.push(array[firstIndex])
        firstIndex += 1
    }
    return stack
}
//
//let stack2 = createAndFetchStackUsingList(array: array1)
//print(stack2.stackTop as Any)
//print(stack2.isEmpty)
//print(stack2.display())
//print("POP", stack2.pop(), stack2.display())
//print("Peek", stack2.peek(4) as Any)

func isParanthesisBalance(array: [String]) -> Bool {
    let stack3 = StackUsingAray<String>(array.count)
    var firstIndex = 0
    while (firstIndex < array.count) {
        if array[firstIndex] == "(" {
            stack3.push("(")
        } else if array[firstIndex] == ")" {
            if stack3.isEmpty {
                return false
            } else {
                stack3.pop()
            }
        }
        firstIndex += 1
    }
    return stack3.isEmpty ? true : false
}

//isParanthesisBalance(array: array2)
//isParanthesisBalance(array: array3)
//isParanthesisBalance(array: array4)

// +, - (1) *,/ (2) L-R

func precedency(_ text: String) -> Int {
    if (text == "+" || text == "-") {
        return 1
    } else if (text == "*" || text == "/") {
        return 2
    }
    return -1
}

func isOperand(_ text: String) -> Bool {
    if (text == "+" || text == "-" || text == "*" || text == "/") {
        return true
    }
    return false
}
    

func infixToPostfix() -> String {
    let stack3 = StackUsingAray<String>(array4.count)
    var index = 0
    var finalResult = ""
    while (index < stack3.size) {
        if !isOperand(array4[index]) {
            finalResult += array4[index]
        } else {
            if stack3.isEmpty {
                stack3.push(array4[index])
            } else {
                while (!stack3.isEmpty && precedency(array4[index]) <= precedency(String(stack3.stackTop ?? ""))) {
                    finalResult += stack3.stackTop ?? ""
                    stack3.pop()
                }
                stack3.push(array4[index])
            }
        }
        index += 1
    }

    while (stack3.top != -1) {
        finalResult += stack3.stackTop ?? ""
        stack3.pop()
    }
    return finalResult
}

//print("Postfix conversion is", infixToPostfix())

func infixtoPrefix() -> String {
    let stack3 = StackUsingAray<String>(array4.count)
    var index = stack3.size - 1
    var finalResult = ""
    while (index >= 0) {
        if !isOperand(array4[index]) {
            finalResult += array4[index]
        } else {
            if stack3.isEmpty {
                stack3.push(array4[index])
            } else {
                while (!stack3.isEmpty && precedency(array4[index]) <= precedency(String(stack3.stackTop ?? ""))) {
                    finalResult += stack3.stackTop ?? ""
                    stack3.pop()
                }
                stack3.push(array4[index])
            }
        }
        index -= 1
    }
    
    while (stack3.top != -1) {
        finalResult += stack3.stackTop ?? ""
        stack3.pop()
    }
    return finalResult.reduce("") { "\($1)" + $0 }
}

//print("Prefix conversion is", infixtoPrefix())
