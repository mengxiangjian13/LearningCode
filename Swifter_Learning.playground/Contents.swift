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
    print("another \(String(describing: a)) nil")
}
if let b = literalNil {
    print("literal \(String(describing: b)) nil")
}

// optional map
let optionalMap : Int? = nil
let optionalInt = optionalMap.map {
    $0 * 2
}
optionalInt

// protocol extension
protocol protocolA {
    func method1()
}

extension protocolA {
    func method1() {
        print("method1")
    }
    
    func method2() { // 在protocol中没有定义
        print("method2")
    }
}
struct ProtocolStructA : protocolA {
    func method1() {
        print("ProtocolStructA method1")
    }
    func method2() {
        print("ProtocolStructA method2")
    }
}
let protocolStructA = ProtocolStructA()
protocolStructA.method1()
let protocolStructB = protocolStructA as protocolA
protocolStructB.method2() // 不会动态派发到ProtocolStructA类型，而是protocolA类型

// where 的实用  4. 泛型 5 extension protocol
let scores : [Int?] = [46,99,nil]
scores.flatMap{return $0}.forEach {
    switch $0 {
    case let x where x > 60:
        print("及格了")
    default:
        print("不及格")
    }
}

let fScores = scores.flatMap{return $0}
for i in fScores where i > 60 {
    print("\(i)分及格了")
}

if let a = scores[1], a > 60 { // 在if和guard中省略where
    print("\(a)分及格了")
}

// indrect 和 嵌套 以enum模拟链表
indirect enum LinkList<Element:Equatable> {
    case empty
    case node(Element, LinkList<Element>)
    func removeNode(_ element: Element) -> LinkList<Element>{
        guard case let .node(value, next) = self else {
            return .empty
        }
        return (value == element) ? next : .node(value, next.removeNode(element))
    }
}

var linkList : LinkList = .node(1, .node(2, .node(3, .node(4, .empty))))
// 1->2->3->4
print(linkList)
let linkList2 = linkList.removeNode(2)
// 1->3->4
print(linkList2)


// Swift Objc
// selector
class ObjcClass {
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(objcSelector), name: NSNotification.Name(rawValue:"notificationname"), object: nil)
    }
    @objc func objcSelector() {
        
    }
    func someFunc() {
        print("type instance method")
    }
}

// Type.instanceMethod
let typeInstanceMethod = ObjcClass.someFunc
typeInstanceMethod(ObjcClass())()

// singleton

class SingletonClass {
    static let shared = SingletonClass()
    private init() {
        // 保证不能在外面通过正常的方式创建新对象，只能使用单例
    }
}
let singleton = SingletonClass.shared

// 条件编译
#if os(iOS)
#endif

// 编译标记
// MARK:
// TODO:
// FIXME:


// Swift 与 Objective-C 互相调用
/**
 1. Swift调用OC,需要生成一个 {product-module-name}-Bridging-Header.h，将暴露出来的OC头文件写入，Swift就可以调用了。
 2. OC调用Swift的framework，与一般的framework一样，使用@import。
 3. OC调用同一个项目中的Swift，则需要import {product-module-name}-Swift.h
 4. 对于2、3，Swift被暴露给OC调用的类，方法等，需要加@objc修饰符，因为OC为动态调用，Swift是静态的，没有运行时信息。
 */

// weak unonwed
class WeakClass {
    var name : String
    init(name:String) {
        self.name = name
    }
    lazy var printself : ()->() = {
        [weak self] in
        // weak 必须是optional类型
        if let strongSelf = self {
            print("weak class print \(strongSelf.name)")
        }
    }
}

// autorelease pool
autoreleasepool {
    // 释放autorelease对象
}

// 值类型和引用类型
/**
 Array和Dictionary被设计成了值类型，从而降低了堆上的内存的分配和回收的次数
 只有在值类型改变的时候，才会复制。值类型容器里面的值类型会复制，引用类型只会复制一份引用。
 但当容器内元素个数过多，或者增加删除操作过于频繁，就会造成复制起来开销太大。所以这种情况，我们可以采用引用型容器，NSMutableArray、NSMutableDictionary
 */

// unsafepointer
var pointer : CInt = 2
func printPointerContent(_ num:UnsafePointer<CInt>) {
    // pointee为指针响应内存中存储的内容
    print(num.pointee)
}
printPointerContent(&pointer)

// GCD
let queue = DispatchQueue(label: "QQQQQQ")
queue.async {
    print("async queue")
    DispatchQueue.main.async {
        print("main queue")
    }
}
queue.asyncAfter(deadline: DispatchTime.now() + 2) {
    print("2 second after")
}

// 通过dispatch_after，来及时 cancel

typealias Task = (Bool) -> ()

func delay(_ delay:TimeInterval, task: @escaping ()->()) -> Task {
    func dispatch_after(block: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: block)
    }
    
    var canceled = false
    
    let madeTask : Task = {
        cancel in
        canceled = cancel
    }
    
    dispatch_after {
        if !canceled {
            task()
        }
    }
    return madeTask
}

let delay110 = delay(5) {
    print("call 110")
}

delay110(true)

