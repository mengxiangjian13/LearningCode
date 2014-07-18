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
    let red = 0.0, green = 0.0, blue = 0.0
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
    let text : String
    var response : String?
    init (text:String)
    {
        self.text = text
    }
    
    func ask()
    {
        println(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like Cheese?")
cheeseQuestion.ask()
cheeseQuestion.text

cheeseQuestion.response = "Yes,I like"






