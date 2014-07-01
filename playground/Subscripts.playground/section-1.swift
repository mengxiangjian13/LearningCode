// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

// subscript
let arr = ["d","f","s","a"]
let letter = arr[2]

let dict = ["1":"a","2":"b"]
let index = dict["2"]

struct TimesTable {
    let multiplier : Int
    subscript(index:Int) -> Int {
        return index * multiplier
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]


enum Day : Int
{
    case Sunday = 0,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
    
    subscript(index:Int) -> Day
    {
        get {
            return Day.fromRaw(index)!
        }
        set(newValue){
            self = newValue
        }
    }
    
    static func chooseDay(index:Int) -> Day {
        return Day.fromRaw(index)!
    }
}

var day = Day.Monday

let wednesday = day[3]
wednesday.toRaw()

day[3] = Day.Sunday
day.toRaw()

let friday = Day.chooseDay(5)
friday.toRaw()


//any count 

struct Matrix {
    let rows : Int
    let columns : Int
    var grid : Double[]
    init(rows:Int,columns:Int)
    {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue:0.0)
    }
    
    func indexIsValidForRow(row:Int,column:Int) -> Bool
    {
        return row >= 0 && row < self.rows && column >= 0 && column < self.columns
    }
    
    subscript(row : Int, column : Int) -> Double
    {
        set {
            assert(indexIsValidForRow(row, column: column), "index out of range")
            grid[row * columns + column] = newValue
        }
        
        get {
            assert(indexIsValidForRow(row, column: column), "index out of range")
            return grid[row * columns + column]
        }
    }
    
    
}

var aM = Matrix(rows: 2, columns: 2)
aM.grid

aM[0,1] = 1.0
aM[1,0] = 2.0

aM.grid

//aM[5,5] 



