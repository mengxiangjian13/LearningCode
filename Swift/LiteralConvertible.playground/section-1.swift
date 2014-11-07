// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
    字面量转换
    字面量就是直截了当的指定变量类型并赋值的值。比如let a = 3
    字面量转换的意思就是用一个字面量赋值一个对象。
    比如给一个person类的对象初始化的时候赋值一个字符串
*/

// 字面量
let a = 3
let b = "abcd"
let c = ["a","b","c","d"]

// 现在给person类初始化赋值
class Person {
    let name : String;
    init(name:String)
    {
        self.name = name;
    }
}

let person = Person(name: "mengxiangjian")

// 字面量转换就是一个person直接已一个字符串初始化，和上面b用"abcd"初始化一样
class Car : StringLiteralConvertible
{
    let name: String;
    init(name:String){
        self.name = name;
    }
    
    required convenience init(stringLiteral value: StringLiteralType)
    {
        self.init(name:value);
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: String)
    {
        self.init(name:value);
    }
    
    required convenience init(unicodeScalarLiteral value: String)
    {
        self.init(name:value);
    }
    
}

//let car = "Benz" 这种写法是错误的，必须规定car是Car类型的才会转换类型，否则直接是字符串
let car : Car = "Benz"
car.name


