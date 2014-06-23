
import Cocoa

var str = "Hello, playground"


func add() -> Int {
    return 0;
}

func addToOne(para:Int) -> Int{
    return para + 1
}

func addToOneWithOutPara(#para:Int) ->Int{
    return para + 1
}

func addToOneAndDefaultTwo(para:Int,two:Int = 2) -> Int{
    return para + 1 + two
}

var a = add()

var b = addToOne(a)

b = addToOneWithOutPara(para: a)

var c = addToOneAndDefaultTwo(b,two:5)

func sum4(numbers:Int...) -> Int[]{
    var i = Int[]()
    for number in numbers{
        i.append(number)
    }
    return i
}

let sum3 = sum4(2,3,4,3,2,3,4,3,2,4)
sum3

func multablePara(var para:Int){
    para = para + 1
}

multablePara(c)
c

func inoutPara(inout a:Int)
{
    a = a + 1
}

inoutPara(&c)
c


func fivePlus(fun : (Int) ->Int){
    let i = 5
    let j = fun(i)
    println(j)
}

fivePlus(addToOne)

func plusOne() -> (Int)->Int
{
    return addToOne
}

let plus1 = plusOne()

let tenPlusOne = plus1(10)











