// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 扩展 与 OC中的类别类似，但没有名字

// 扩展不能添加 存储属性，也不能添加属性观察器 可以添加计算属性，

extension Double {
    var km : Double {return self * 1000.0}
    var  m : Double {return self}
    var cm : Double {return self / 100.0}
    var mm : Double {return self / 1000.0}
}

let aMarathon = 42.km + 195.m
let a = "marathon total length is \(aMarathon)m"



// initializer 构造器 在扩展里面不能添加指定构造器或者析构函数，只能添加便利构造器
// 不再举例


// function
extension Int {
    func repetitions(task:()->()) {
        for i in 0..<self
        {
            task()
        }
    }
}

// 利用尾随闭包
4.repetitions{
    println("task done!")
}

//如果利用方法改变自己的值，为修改实例方法，必须加mutating标注
extension Int{
    mutating func square()
    {
        self = self * self
    }
    mutating func exponent(a:Int)
    {
        let b = self
        if a > 0
        {
            for i in 0..<a - 1
            {
                self *= b
            }
        }
        else
        {
            self = 1
        }
    }
}

var someInt = 3
someInt.square()
someInt

// subscript
extension Int {
    // 取int数字某位上的数字
    subscript(digitIndex:Int) -> Int
    {
        var ten = 10
        ten.exponent(digitIndex)
        let b = ten
        return self / b % 10
    }
}

let c = 12345678[0]


//嵌套类型 Nested Type

extension Character
{
    enum Kind {
        case Vowel, Consonant, Other
    }
    
    // 字符类 嵌套kind枚举
    var kind : Kind
    {
        switch String(self).lowercaseString{
            case "a", "e", "i", "o", "u":
                return .Vowel
            case "b", "c", "d", "f", "g", "h", "j",
                "k","l","m","n","p","q","r","s","t",
                "v","w","x","y","z" :
                return .Consonant
            default :
                return .Other
        }
    }
}

func printLetterKinds(word:String){
    println("'\(word)' is made up of the following kinds of letter:")
    for character in word
    {
        switch character.kind
        {
            case .Vowel:
                println("wowel ")
            case .Consonant:
                println("consonant ")
            case .Other:
                println("other")
        }
    }
}

printLetterKinds("hello,world!")

