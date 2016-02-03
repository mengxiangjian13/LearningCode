// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 泛型

//<>里面的T是泛型自己定义的类型，告诉swift不去追求T到底是什么类型。等真正被调用的时候，传进来的参数是什么类型，T就会被那个类型替换
// 不是必须使用T来表示泛型类型，可以使用其他名称，但要保持大写字母开头的驼峰式命名
func swapTwoItems<T>(inout a:T,inout _ b:T)
{
    let temp = a
    a = b
    b = temp
}

var a = 4
var b = 5
swapTwoItems(&a, &b)
a
b

// 泛型类型；栈 [T]()为一个里面所有元素为T类型的空数组，[T]是说数组的类型
struct Stack<T> {
    var items = [T]()
    mutating func push(item:T)
    {
        items.append(item)
    }
    
    mutating func pop() -> T
    {
        return items.removeLast()
    }
}

// 类型约束
// 泛型是说可以不用考虑类型。但有些时候，需要进行一些条件约束，比如类型必须是继承自某个类，或者必须是接受了某个协议。
// T : 约束
func findIndex<T:Equatable>(array:[T],valueToFind:T) -> Int?
{
    for (index, value) in array.enumerate()
    {
        if value == valueToFind // 只有实现Equatable协议的才可以==
        {
            return index
        }
    }
    return nil
}

findIndex([1,2,3], valueToFind: 2)

// 关联类型行为
protocol SomeProtocol {
    typealias ItemType
    var a : ItemType {get set}
}

struct IntStruct : SomeProtocol {
    var a : Int = 3
}

struct StringStruct : SomeProtocol {
    var a : String = "3"
}


// where 语句 给泛型类型以控制
func allItemMatch<T1:SomeProtocol,T2:SomeProtocol where T1.ItemType == T2.ItemType, T1.ItemType:Equatable>(a:T1,b:T2) -> Bool {
    if a.a == b.a {
        return true
    }
    return false
}

let someInt = IntStruct(a: 6)
let someInt2 = IntStruct(a: 3)
let someInt3 = IntStruct()
let someString = StringStruct(a: "4")
let someString2 = StringStruct(a: "4")

//let match = allItemMatch(someString, b: someInt2) // 不符合1 2类型相同

let match = allItemMatch(someInt, b: someInt2)
let match1 = allItemMatch(someInt2, b: someInt3)
let match2 = allItemMatch(someString, b: someString2)

