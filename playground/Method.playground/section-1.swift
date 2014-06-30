// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


class Counter {
    var count = 0
    func increment() {
        count++
    }
    
    func incrementBy(amount:Int) {
        count += amount
    }
    
    func incrementBy(amount:Int,times:Int) {
        count += amount * times
    }
    
    func reset()
    {
        count = 0
    }
}

var count = Counter()
count.incrementBy(5, times: 3)

struct Point {
    var x = 0.0
    var y = 0.0
    func isToTheRightOfX(x:Double) -> Bool{
        return self.x > x
    }
    
    mutating func moveBy(deltaX:Double,deltaY:Double){
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    let h = "this point is right of 1.0"
}

let thePoint = somePoint
somePoint.moveBy(2.0, deltaY: 3.0)
somePoint
thePoint

enum TriStateSwitch : Int {
    case Off = 0,Low,High
    mutating func next(){
        switch self {
            case Off:
                self = Low
            case Low:
                self = High
            case High:
                self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.toRaw()
ovenLight.next()
ovenLight.toRaw()
ovenLight.next()
ovenLight.toRaw()


