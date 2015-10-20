// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

struct Fahrenheit {
    var temperature : Double
    // constructor
    init()
    {
        temperature = 32.0
    }
}

var f = Fahrenheit()
f.temperature

struct Celsius
{
    var temperatureInCelsius:Double = 0.0
    init(fromFahrenheit fahrenheit : Double)
    {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8;
    }
    init(fromKelvin kelvin : Double)
    {
        temperatureInCelsius = kelvin - 273.15;
    }
}

let boilingPoint = Celsius(fromFahrenheit: 212.0)
boilingPoint.temperatureInCelsius
let freezingPoint = Celsius(fromKelvin: 273.15)
freezingPoint.temperatureInCelsius

struct Color {
    var red = 0.0, green = 0.0, blue = 0.0
    init (red : Double, green : Double , blue : Double)
    {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

let redColor = Color(red: 255.0, green: 0, blue: 0)

//optional property

class SurveyQuestion
{
    // constant only can be modified in initializer
    let text : String
    var response : String?
    init (text:String)
    {
        self.text = text
    }
    
    func ask()
    {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like Cheese?")
cheeseQuestion.ask()
cheeseQuestion.text

cheeseQuestion.response = "Yes,I like"


struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var height = 0.0
}


struct Rect {
    var origin = Point()
    var size = Size()
    
    init(){
        
    }
    
    init(origin:Point,size:Size)
    {
        self.origin = origin
        self.size = size
    }
    
    init(center:Point,size:Size)
    {
        let originX = center.x - size.width / 2.0
        let originY = center.y - size.height / 2.0
        self.init(origin:Point(x: originX, y: originY),size:size)
    }
}

let rect = Rect(center: Point(x: 100, y: 100), size: Size(width: 100, height: 100))
rect.size
rect.origin


class Food {
    var name : String
    init(name:String)
    {
        self.name = name
    }
    convenience init() {
        self.init(name:"[Unnamed]")
    }
}

class RecipeIngredient : Food
{
    var quality : Int
    init(name:String, quality:Int)
    {
        self.quality = quality;
        super.init(name: name)
    }
    convenience override init(name: String)
    {
        self.init(name:name, quality:1)
    }
}

class ShppingListItem : RecipeIngredient
{
    var purchased = false
    var description : String {
        var output = "\(quality) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfast = ShppingListItem()
breakfast.description

var bacon = ShppingListItem(name: "Bacon")
bacon.description

var egg = ShppingListItem(name:"egg", quality:6)
egg.description





