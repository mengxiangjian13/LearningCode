// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Vector2D {
    let x : Int;
    let y : Int;
}

let v1 = Vector2D(x: 1, y: 2);
let v2 = Vector2D(x: 2, y: 3);

// 操作符重载。如果是重载已经有的操作符，就和func的声明一致。
func +(pre:Vector2D,suf:Vector2D) -> Vector2D
{
    return Vector2D(x: pre.x + suf.x, y: pre.y + suf.y);
}

let v3 = v1 + v2;

// 新操作符需要预先声明
infix operator +* {
    associativity none // 运算顺序，如果几个连续的+*运算，规定运算顺序。可以是Left（从左至右）
    precedence 160 // 优先级 加减法是140，乘除是150。
}

func +*(pre:Vector2D,suf:Vector2D) -> Int
{
    return pre.x * suf.x + pre.y + suf.y;
}

