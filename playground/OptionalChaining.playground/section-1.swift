// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    var residence : Residence?
}

//class Residence {
//    var numberOfRooms = 1
//}
//
//let john = Person()
//
//let roomCount = john.residence!.numberOfRooms //run error.   residence = nil
//
//john.residence = Residence()
//
//if let count = john.residence?.numberOfRooms
//{
//    print("john's room has \(count) rooms")
//}
//else
//{
//    print("unable to get the count")
//}

class Residence {
    var rooms = [Room]()
    
    var numberOfRooms : Int {
        return rooms.count
    }
    
    subscript(i:Int) -> Room{
        return rooms[i]
    }
    
    func printNumberOfRooms()
    {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address : Address?
}

class Address
{
    var buildingName : String?
    var buildingNumber : String?
    var street : String?
    func buildingIdentifier() -> String?
    {
        if buildingName != nil
        {
            return buildingName
        }
        else if buildingNumber != nil
        {
            return buildingNumber
        }
        else
        {
            return nil
        }
    }
}

class Room
{
    let name :String
    init(name:String)
    {
        self.name = name;
    }
}


let john = Person()

// 通过可选链调用属性
if let roomCount = john.residence?.numberOfRooms
{
    print("john's residence has \(roomCount) rooms")
}
else
{
    print("unable to get number of rooms")
}

// 通过可选链调用方法
if (john.residence?.printNumberOfRooms() != nil)
{
    print("it can print room count")
}
else
{
    print("unable to print room count")
}

// 通过可选链调用下标脚本
john.residence = Residence()
john.residence!.rooms.append(Room(name: "Bed Room"))
john.residence!.rooms.append(Room(name: "Living Room"))

if let name = john.residence?[0].name
{
    print("room0's name is \(name)")
}
else
{
    print("unable to get room0's name")
}

if let street = john.residence?.address?.street
{
    print("john's residence address is \(street)")
}
else
{
    print("unable to get address street")
}

// 链接可选返回值的方法
if let buildingIdentifier = john.residence?.address?.buildingIdentifier()
{
    print("john's residence building identifier is \(buildingIdentifier)")
}






