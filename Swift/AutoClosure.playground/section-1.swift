// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
    本代码是学习@autoclosure
*/

// 参数是()->bool类型的闭包
func logIfTrue(closure:()->Bool)
{
    if closure()
    {
        println("true");
    }
}

logIfTrue(){
    4 > 3
}

// 上面的参数样式的闭包可以用@closure简化
func logIfTrueNew(closure: @autoclosure ()->Bool)
{
    if closure()
    {
        println("true");
    }
}

logIfTrueNew(2>1)

// ?? 操作符 用法如下。

let a = nil;
let b = 2;
let c = a ?? b; // ??前面不为nil的时候，取前面的。在??前面的为nil的时候，取后面的。

/*  
    其实上面的??操作符声明(操作符重载)如下。
    func ??<T>(optional: T?, defaultValue: @autoclosure () -> T?) -> T?
    func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T
    后面的参数采用@autoclosure的原因是如果前者不为nil，就用不到后者，如果提前算好后者就会有无为的开销。所以如果前者为nil时，再调用闭包去返回后者
*/

//// 练习。试着实现&& || 的实现
func && (pre:Bool,suf:@autoclosure ()->Bool) -> Bool
{
    if pre == false
    {
        return false;
    }
    
    if suf() == true
    {
        return true;
    }
    
    return false;
}

let t = true;
let f = true;
let u = a&&b;




