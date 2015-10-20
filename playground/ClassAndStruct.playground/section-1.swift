// Playground - noun: a place where people can play

import Cocoa

// class 实例为引用类型
// struct 实例为值类型

var str = "Hello, playground"

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution  = Resolution(width: 1024, height: 768)
    var interlaced = false
    var frameRate = 0.0
    var name : String?
}

let videoMode = VideoMode()
videoMode.name = "2"

let resolutionWidth = videoMode.resolution.width
videoMode.resolution.width = 320
videoMode.resolution.height = 568

var dd = videoMode.resolution

dd.height = 480
videoMode.resolution

let aVideoMode = videoMode
aVideoMode.name = "3"

videoMode.name

if videoMode === aVideoMode {
    print("vide0Mode equals to aVideoMode")
}

var dict = ["a" : 1 ,"b" : 2, "c" : 3]
var dict2 = dict
dict2["a"] = 0
dict
dict2

var a = [1,2,3]
var b = a
var c = b

a[0] = 42 //reference
a
b
c

a.append(4) // copy
a[0] = 777
a
b
c

//b.unshare()
b[0] = -105

a
b
c










