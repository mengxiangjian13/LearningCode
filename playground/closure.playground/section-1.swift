
import Cocoa

var str = "Hello, playground"

var names : [String] = ["Addd","Rddd","Eddd","Cddd","Gddd"]

var sortedArr = names.sort()

func sortPrinciple(a:String,b:String) ->Bool{
    return a>b
}

var descArr = names.sort(){(a:String,b:String)->Bool in return a>b}

descArr

descArr = names.sort(){a,b in return a > b}
descArr = names.sort(){a,b in a > b}
descArr = names.sort(){$0 > $1}

//trailing closures
descArr = names.sort(){
    $0 > $1
}

descArr

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map{
    (number) -> String in
    
    var output = String(number)
    var result = ""
    for c in output.characters {
        result += String(c) + "/"
    }
    
    return result
}

let oStrings = ["1","2","3","4"];

let oNumber = oStrings.map(){
    string -> Int in
    
    var a = Int(string)!
    return a
}


func incrementBy10() -> () ->Int
{
    var a = 0
    return {()->Int in
        a += 10
        return a
    }
}

var plus10 = incrementBy10()

plus10()
plus10()


func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)

incrementByTen()
incrementByTen()

func tenten() -> Int{
    var a = 0
    a += 10
    return a
}

tenten()
tenten()

var myname = "hello,mengxiangjian,"
let closure = {(name:String) -> String in
    myname += name
    return myname
}

closure("gzy")
closure("gzy")


