// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class MediaItem {
    var name:String
    init(name:String)
    {
        self.name = name
    }
}

class Movie : MediaItem
{
    var director : String
    init(name: String, director:NSString)
    {
        self.director = director
        super.init(name: name)
    }
}

class Song : MediaItem
{
    var artist : String
    init(name: String, artist:NSString)
    {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// type checking
var songCount = 0
var movieCount = 0
for item in library
{
    if item is Movie
    {
        ++movieCount
    }
    else
    {
        ++songCount
    }
}
movieCount
songCount


// downcasting as?
for item in library
{
    if let movie = item as? Movie
    {
        println("Movie:\(movie.name),dir.\(movie.director)")
    }
    else if let song = item as? Song
    {
        println("Song:\(song.name),by\(song.artist)")
    }
}

//Any or AnyObject

// 混合类型可以用Any（不包括function类型）和 AnyObject。使用的时候downcasting一下。

