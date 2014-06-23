// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


// captitalized
enum Direction :Int{
    case North = 1, South, East, West
}

let direction = Direction.East;
let raw = direction.toRaw()

let from = Direction.fromRaw(2)!
let south = from.toRaw()


enum Transportation {
    case Car(Float)
    case Bus(Float)
}

var way = Transportation.Car(0.5)

switch way
{
    case .Car(let time):
        let response = "car takes time \(time) hours"
    case .Bus(let time):
        let response = "bus takes time \(time) hours"
}



