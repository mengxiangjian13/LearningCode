// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

struct Car {
    let wheel : Int
    var engine : Int
}

var car = Car(wheel: 4, engine: 1)
car.engine = 2
//car.wheel =2 can't change

let train = Car(wheel: 5000, engine: 1)
//train.engine = 2 can't change

class Train{
    let wheel = 0
    var engine = 0
}

let aTrain = Train()
aTrain.engine = 1


struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var point = Point()
    var size = Size()
    var center:Point {
        get {
            let centerX = point.x + size.width / 2.0
            let centerY = point.y + size.height / 2.0
            return Point(x: centerX, y: centerY)
        }
        set {
            // newValue 是设置的新值
            point.x = newValue.x - size.width / 2.0
            point.y = newValue.y - size.height / 2.0
        }
    }
}

var square = Rect(point: Point(x: 200, y: 200), size: Size(width: 200, height: 200))

let firstRect = square
firstRect.center

square.center = Point(x: 100, y: 100)
square


struct Cuboid {
    var width = 0.0
    var height = 0.0
    var depth = 0.0
    
    // must var
    var volumn : Double {
    get{
        return width * height * depth
    }
    }
}

let aCub = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
aCub.volumn

struct SomeStruct {
    static var storedProperty = "hello"
    static let aStored = "hh"
    
    var dynamicValue : String {
    willSet{
        newValue
    }
    didSet{
        oldValue
    }
    }
    
    var all :String {
        return SomeStruct.aStored + SomeStruct.storedProperty
    }
}

SomeStruct.aStored
SomeStruct.storedProperty
SomeStruct.storedProperty = "dddddd"
SomeStruct.storedProperty
var ss = SomeStruct(dynamicValue: "d")
ss.dynamicValue = "ddd"

ss.all


