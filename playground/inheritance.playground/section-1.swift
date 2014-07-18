// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


// heritage

class Vehicle {
    
    var numberOfWheels : Int
    var maxPassengers : Int
    
    func description() -> String
    {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    
    init(){
        numberOfWheels = 0
        maxPassengers = 1
    }
    
}

let someVehicle = Vehicle()
someVehicle.description()

class Bicycle : Vehicle {
    
    init() {
        super.init()
        numberOfWheels = 2
    }
    
}

let someBicycle = Bicycle()
someBicycle.description()

class Giant : Bicycle
{
    
    init()
    {
        super.init()
        maxPassengers = 2
    }
    
}


let someGiant = Giant()
someGiant.description()


// override
// function class subscript

// override method
class Car : Vehicle
{
    var speed : Double
    init()
    {
        speed = 0
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    
    override func description() -> String
    {
        return super.description() + ";" + "traveling at \(speed) mph"
    }
}

let someCar = Car()
someCar.speed = 222
someCar.description()

// override property
class speedLimitedCar : Car
{
    override var speed : Double{
    get {
        return super.speed
    }
    set{
        super.speed = min(newValue, 40.0)
    }
    }
}

let someSpeedCar = speedLimitedCar()
someSpeedCar.speed = 60.0
someSpeedCar.description()


// override propery observer
class AutomaticCar : Car
{
    var gear = 1
    override var speed : Double
    {
    didSet {
        gear = Int(speed / 10.0) + 1
    }
    }
    
    override func description() -> String
    {
        return super.description() + " in gear \(gear)"
    }
}

let someAutomaticCar = AutomaticCar()
someAutomaticCar.speed = 35.0
someAutomaticCar.description()


// @final





