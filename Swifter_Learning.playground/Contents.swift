//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// currying
func addTo(_ adder:Int) -> (Int) -> Int {
    return {
        number in
        return adder + number
    }
}

addTo(2)(3)

// mutating protocol
// modify struct/enum var
protocol MutatingProtocol {
    mutating func changeName(_ name: String)
}

struct MutatingStruct : MutatingProtocol {
    var name = "ok"
    
    mutating func changeName(_ name: String) {
        self.name = name
    }
}

// sequence

struct SequenceIterator<T> : IteratorProtocol {
    
    var array : [T]
    var currentIndex : Int
    init(array:[T]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    typealias Element = T
    mutating func next() -> T? {
        if currentIndex < 0 {
            return nil
        } else {
            let e = self.array[currentIndex]
            currentIndex -= 1
            return e
        }
    }
}

struct SequenceStruct<T> : Sequence {
    typealias Element = T
    var array : [T]
    init(array:[T]) {
        self.array = array;
    }
    typealias Iterator = SequenceIterator<T>
    func makeIterator() -> SequenceIterator<T> {
        return SequenceIterator<T>(array:self.array)
    }
}

let sequenceArray = [1,2,3,4,5]
for i in SequenceStruct(array:sequenceArray) {
    print(i)
}

// tuple

func swap<T>(a: inout T, b: inout T) {
    (a,b) = (b,a)
}

var swapa = 1
var swapb = 2
swap(&swapa, &swapb)
(swapa,swapb)

// @autoclosure ??
func logIfTrue(_ block : @autoclosure () -> Bool) {
    if block() {
        print("log if true")
    }
}
logIfTrue(2 > 1)

// @escape
func logBlockAsync(block: @escaping ()->()) {
    DispatchQueue.main.async {
        block()
    }
}
logBlockAsync {
    print("escaping")
}

// operator 操作符 重载和新建
struct Vector2D {
    var x = 0.0
    var y = 0.0
}

func +(_ left:Vector2D,_ right:Vector2D) -> Vector2D{
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

prefix func -(_ pre:Vector2D) -> Vector2D{
    return Vector2D(x: -pre.x, y: -pre.y)
}

precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator +*:DotProductPrecedence
func +*(_ left:Vector2D,_ right:Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

var v1 = Vector2D(x: 1.0, y: 2.0)
var v2 = Vector2D(x: 2.0, y: 5.0)
var v3 = v1 + v2
var v4 = -v3
var v5 = v1 +* v2

// subscript
extension Array {
    subscript (input:[Int]) -> ArraySlice<Element> {
        get {
            var re = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "out of range")
                re.append(self[i])
            }
            return re
        }
        
        set {
            assert(input.count == newValue.count, "count is not equal")
            for (index, i) in input.enumerated() {
                assert(i < self.count, "out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var subscriptArray = [1,2,3,4,5]
subscriptArray[[1,4]]
subscriptArray[[1,4]] = [11,44]

// typealias
protocol Dog {}
protocol Cat {}
typealias DogAndCat = Dog & Cat

// 可变参数函数
func changeableVarFunc(input:Int...) {
    print(input)
}
changeableVarFunc(input: 2,3,4)

// classs init
class A {
    var num : Int
    required init(num:Int) {
        self.num = num
    }
    convenience init(bigNum:Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
    func ok() {
        print("ok")
    }
}

class B : A{
    var bNum : Int
    required init(num:Int) {
        self.bNum = 2
        super.init(num: num)
    }
}

let bInstance = B(bigNum: true)
bInstance.num
bInstance.bNum
bInstance.ok()

// init optional
class CanBeNil {
    var a : Int
    init(a:Int) {
        self.a = a
    }
    
    convenience init?(canbenil:Bool) {
        if canbenil {
            return nil
        }
        self.init(a: 3)
    }
}

let canbenil = CanBeNil(canbenil: true)
let canbenil2 = CanBeNil(canbenil: false)
canbenil2?.a

// static class
class StaticClass {
    static var a : Int = 1
    var b : Int
    init(b:Int) {
        self.b = b
    }
    static let sharedInstance = StaticClass(b:2)
    static func func1() {
        
    }
    class func func2() {
        
    }
}
StaticClass.func1()
StaticClass.sharedInstance.b = 5

// default 参数
func defaultParam(one:Int = 2, two:Int, three:Int) -> Int{
    return one + two + three
}
defaultParam(two: 4, three: 6)
defaultParam(one: 0, two: 4, three: 6)

// 模式匹配  ~=   switch
func ~=(_ lhs:Int, _ rhs:String) -> Bool {
    return Int(rhs) == lhs
}

let someString = "3"
switch someString {
case 3:
    print("string equals to int")
default:
    print("none")
}

// ... ..<
for i in 0...3 {
    print("this is \(i)")
}
let ints = 0..<3
ints.contains(2)

let someHello = "helLo"
let inteval = "a"..."z"
for c in someHello.characters {
    if !inteval.contains(String(c)) {
        print("\(c) is not a 小写字母")
    }
}

// 'self' in protocol and class method
class SelfClass {
    required init() {
        
    }
    class func createInstance() -> Self {
        let alloc = self.init()
        return alloc
    }
    lazy var a = 3
}

// lazy
SelfClass.createInstance().a = 2

let mapArray = [1,2,3,4,5]
let doubleArray = mapArray.lazy.map {
    return $0 * 2
}

for i in doubleArray {
    print("lazy \(i)")
}

// mirror
let mirror = Mirror(reflecting:SelfClass.createInstance())
mirror.children
mirror.displayStyle

// 多重optional
var aNil : String? = nil
var anotherNil : String?? = aNil
var literalNil : String?? = nil
if let a = anotherNil {
    print("another \(a) nil")
}
if let b = literalNil {
    print("literal \(b) nil")
}

// optional map
let optionalMap : Int? = 3
let optionalInt = optionalMap.map {
    $0 * 2
}
optionalInt

