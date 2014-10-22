// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let a = [1,2,3,4,5,6];
a.filter(){
    $0 == 3
}

a.map(){
    $0 * 10
}

extension Array {
    var decompose : (head: T, tail: [T])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
}

func qsort(input: [Int]) -> [Int] {
    if let (pivot, rest) = input.decompose {
        let lesser = rest.filter { $0 < pivot }
        let greater = rest.filter { $0 >= pivot }
        return qsort(lesser) + [pivot] + qsort(greater)
    } else {
        return []
    }
}

// 给a快速排列
qsort(a)
