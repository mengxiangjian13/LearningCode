// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 嵌套类型，即struct enum class 可以互相嵌套

struct BlackjackCard {
    // 嵌套定义枚举类型Suit
    enum Suit : Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套定义枚举类型Rank
    enum Rank : Int
    {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first : Int
            let second : Int?
        }
        
        var value : Values
        {
            switch self
            {
                case .Ace :
                    return Values(first: 1, second: 11)
                case .Jack,.Queen,.King:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.toRaw(), second: nil)
            }
        }
    }
    
    // BlackjackCard 属性
    let rank:Rank, suit : Suit
    var description : String {
        var output = "suit is \(suit.toRaw())"
        output += " value is \(rank.value.first)"
        if let second = rank.value.second
        {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfDimond = BlackjackCard(rank: .Ace, suit: .Diamonds)
theAceOfDimond.description





