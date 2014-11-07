// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


extension Array{
    // 这是下角标大于两个的下标方法。如果只有一个，就和原来的下标定义冲突了。
//    subscript(input:Int...)->Slice<T>{
//        get{
//            var arr = Slice<T>()
//            for i in input{
//                assert(i < self.count, "out of range")
//                arr.append(self[i]);
//            }
//            return arr;
//        }
//        set{
//            for (index,i) in enumerate(input)
//            {
//                assert(i < self.count, "out of range")
//                self[i] = newValue[index]
//            }
//        }
//    }
    
    // 综上，可以采用以下形式。前两个参数必须填写，所以不会与默认的下标冲突
    subscript(first:Int,second:Int,other:Int...)->Slice<T>{
        get {
            assert(first < self.count, "first out of range")
            assert(second < self.count, "second out of range")
            var arr = Slice<T>()
            arr.append(self[first])
            arr.append(self[second])
            for i in other{
                assert(i < self.count, "other out of range")
                arr.append(self[i])
            }
            return arr
        }
        set {
            assert(2 + other.count == newValue.count, "count not equal")
            assert(first < self.count, "first out of range")
            assert(second < self.count, "second out of range")
            self[first] = newValue[0]
            self[second] = newValue[1]
            for (index,i) in enumerate(other){
                assert(i < self.count, "other is out of range")
                self[i] = newValue[index + 2]
            }
        }
    }
}

var array = [1,2,3,4,5]

array[1,2,3]

array[1,2,3] = [-2,-3,-4]

array
