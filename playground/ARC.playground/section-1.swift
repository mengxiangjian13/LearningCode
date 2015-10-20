// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

// weak reference

class Person {
    let name : String
    init(name:String)
    {
        self.name = name
    }
    var apartment : Apartment?
    
    deinit{
        let a = "ggggg"
    }
}

class Apartment
{
    let number : Int
    init (number : Int)
    {
        self.number = number
    }
    
    // must weak
    weak var tenant : Person?
    
    deinit{
        let a = "ggggg"
    }
}

var john : Person?
var number73 : Apartment?

john = Person(name: "john")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil


// unowned reference

class Customer {
    let name : String
    var card : CreditCard?
    init(name:String)
    {
        self.name = name
    }
}

class CreditCard {
    let number : Int
    unowned let customer : Customer
    init(number:Int, customer:Customer)
    {
        self.number = number
        self.customer = customer
    }
}

var meng : Customer?
meng = Customer(name: "meng")
meng!.card = CreditCard(number: 123333, customer: meng!)

//MARK:
//TODO:closure ARC retain cycle

// closure 

class HTMLElement {
    
    let name : String
    let text : String?
    
    lazy var asHTML : () -> String = {
        [unowned self] in
        if let text = self.text{
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        return "<\(self.name)/>"
    }
    
    init(name:String,text:String? = nil)
    {
        self.name = name
        self.text = text
    }
    
    deinit{
        print("ffff")
    }
}

var paragraph :HTMLElement? = HTMLElement(name: "p", text: "hello,world")
paragraph!.asHTML()
paragraph = nil




