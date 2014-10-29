// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
    本代码是说明如何规定for in循环的具体实现
    比如如何让一个数组循环的时候倒序。
*/

struct ReverseGenerator<T> : GeneratorType
{
    typealias Element = T;
    
    var index : Int // 当前输出的index
    var array : [T];
    init(array:[T])
    {
        index = array.count;
        self.array = array;
    }
    
    // 在struct 或者 enum中改变成员变量必须加mutating
    mutating func next() -> Element?
    {
        index = index - 1; // 倒序
        return index < 0 ? nil : self.array[index] // 返回nil就不会接着循环下去了。
    }
}

struct ReverseSequence<T> : SequenceType
{
    typealias Generator = ReverseGenerator<T>;
    
    var array : [T]
    
    init (array:[T])
    {
        self.array = array;
    }
    
    func generate() -> Generator
    {
        return ReverseGenerator(array: array);
    }
}

var array = ["a","b","3","5","r"];

for i in ReverseSequence(array: array)
{
    println(i); // 输出结果为 r,5,3,b,a
}