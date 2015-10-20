// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 协议定义完成某项任务或者功能所必须的方法和属性，但是并不实际实现。
// 协议的遵循者提供特定的实例属性，实例方法，类方法，操作符或下标脚本等。


// 协议对属性的规定
protocol PropertyProtocol {
    var getProperty:Int{get} //计算属性，只读属性
    var settableProperty:Int{get set} // 存储属性 读写属性
    static var classProperty:Int{get set} // 类属性
    
}

// 例子 实例属性协议
protocol FullName
{
    var fullName : String{get}
}

struct Person : FullName
{
    var prefix : String?
    var name : String
    
    init(name:String, prefix:String?)
    {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName : String
    {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}

var myName = Person(name: "Meng", prefix: "James")
myName.fullName


// 协议对方法的规定
protocol RandomNumberGenerator
{
    func random() -> Double
}

class linerContruentialGenerator : RandomNumberGenerator
{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double
    {
        lastRandom = (lastRandom * a + c) % m
        return lastRandom / m
    }
}

let generator = linerContruentialGenerator()
generator.random()
generator.random()
generator.random()

// mutating 方法的规定
protocol Togglable
{
    mutating func toggle() // 在值类型，可以修改实例的类型
    // 用类实现协议方法时，不加mutating。 枚举和结构体必须加mutating
}

enum OnOffSwitch : Togglable
{
    case Off,On
    mutating func toggle()
    {
        switch self {
        case .Off :
            self = .On
        case .On:
            self = .Off
        }
    }
}


// 协议类型
// 作为函数、方法、或构造器中的参数类型或者返回值类型
// 作为常量、变量、属性的类型
// 作为数组、字典或者其他容器中的元素类型

// Dice（骰子） 类
class Dice {
    let sides : Int
    let generator : RandomNumberGenerator
    init(sides:Int,generator:RandomNumberGenerator)
    {
        self.sides = sides
        self.generator = generator
    }
    func roll()->Int
    {
        return Int(generator.random() * Double(sides)) + 1
    }
}

let dice = Dice(sides: 6, generator: generator)
dice.roll()
dice.roll()
dice.roll()


// 委托（代理）模式 
// 上面的Dice就可以看成代理模式 Dice类的roll方法需要生成随机数，自己不能做到，只能让接受代理的类来做


// 在扩展里面添加协议成员
protocol TextRepresentable {
    func asText()->String
}

extension Dice : TextRepresentable
{
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

let textPresentation = dice.asText()

// 通过扩展补充协议声明
// 即便在类、结构体、枚举等类型中，已经实现了协议的所有要求，但没有声明接受了协议，可以用扩展来声明接受协议
struct Hamster {
    var name :String
    func asText()->String{
        return "A hamster named \(name)"
    }
}

extension Hamster : TextRepresentable
{
    
}

let simonHamster = Hamster(name: "simon")
let textRepresentable : TextRepresentable = simonHamster
textRepresentable.asText()


// 集合中的协议类型
let thing : [TextRepresentable] = [dice,simonHamster]
thing[0].asText()


// 协议的继承 
protocol prettyTextRepresentable : TextRepresentable
{
    func asPrettyText()->String
}

extension Dice : prettyTextRepresentable
{
    func asPrettyText()->String{
        return self.asText() + "," + "I have the \(self.roll())"
    }
}

dice.asPrettyText()


// 协议的合成
protocol Named {
    var name :String {get}
}

protocol Aged {
    var age : Int {get}
}

struct People : Named, Aged {
    var name : String
    var age : Int
}

func printOnePeople(people:protocol<Named,Aged>) ->String
{
    return "One people named \(people.name),aged \(people.age)"
}

let people = People(name: "Meng", age: 25)
printOnePeople(people)


/// 协议的一致性
//  is as 转换 可以判断类是否遵循了这个协议
//  判断is as protocol中的protocol必须带有@objc标志，@objc标志表示可选，也用来表示能暴露给objc代码，@objc只对类生效，判断协议的一致性，不能用结构体和枚举判断


// 对可选协议的规定 在可选的属性，方法等前面加@optional 必须加@objc
@objc protocol CounterDataSource {
    optional func incrementForCount(count:Int)->Int
    optional var fixedIncrement:Int{get}
}

class Counter {
    var count = 0
    var dataSource : CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count)
        {
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement
        {
            count += amount
        }
    }
}

class ThreeSource : CounterDataSource
{
    @objc let fixedIncrement = 3
}

class OneIncrementSource : CounterDataSource
{
    @objc func incrementForCount(count: Int) -> Int
    {
        return 1 + count
    }
}

let counter = Counter()
counter.dataSource = ThreeSource()
counter.increment()
counter.count

counter.count = 0
counter.dataSource = OneIncrementSource()
counter.increment()
counter.count











