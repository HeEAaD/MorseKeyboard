//
//  MorseSequence.swift
//  Morse
//
//  Created by Steffen on 12.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import Foundation

enum MorseSymbol : Character {
    case Dah = "−"
    case Dit = "·"
}

class MorseSequence : Printable {

    var symbols : [MorseSymbol]

    var description: String {
        return symbols.reduce("") { $0 + $1.toRaw() }
    }

    var intepretation : Character? {
        switch description {
            case "·−"    : return "A"
            case "−···"  : return "B"
            case "−·−·"  : return "C"
            case "−··"   : return "D"
            case "·"     : return "E"
            case "··−·"  : return "F"
            case "−−·"   : return "G"
            case "····"  : return "H"
            case "··"    : return "I"
            case "·−−−"  : return "J"
            case "−·−"   : return "K"
            case "·−··"  : return "L"
            case "−−"    : return "M"
            case "−·"    : return "N"
            case "−−−"   : return "O"
            case "·−−·"  : return "P"
            case "−−·−"  : return "Q"
            case "·−·"   : return "R"
            case "···"   : return "S"
            case "−"     : return "T"
            case "··−"   : return "U"
            case "···−"  : return "V"
            case "·−−"   : return "W"
            case "−··−"  : return "X"
            case "−·−−"  : return "Y"
            case "−−··"  : return "Z"
            case "−−−−−" : return "0"
            case "·−−−−" : return "1"
            case "··−−−" : return "2"
            case "···−−" : return "3"
            case "····−" : return "4"
            case "·····" : return "5"
            case "−····" : return "6"
            case "−−···" : return "7"
            case "−−−··" : return "8"
            case "−−−−·" : return "9"
            case "·−−·−" : return "À"
            case "·−·−"  : return "Ä"
            case "·−··−" : return "È"
            case "··−··" : return "É"
            case "−−−·"  : return "Ö"
            case "··−−"  : return "Ü"
            case "···−−··" : return "ß"
//            case "−−−−" : return "CH"
            case "−−·−−"  : return "Ñ"
            case "·−·−·−" : return "."
            case "−−··−−" : return ","
            case "−−−···" : return ":"
            case "−·−·−·" : return ";"
            case "··−−··" : return "?"
            case "−····−" : return "-"
            case "··−−·−" : return "_"
            case "−·−−·"  : return "("
            case "−·−−·−" : return ")"
            case "·−−−−·" : return "'"
            case "−···−"  : return "="
            case "·−·−·"  : return "+"
            case "−··−·"  : return "/"
            case "·−−·−·" : return "@"
            default:
                return nil
        }
    }

    init() {
        symbols = []
    }

    init(symbols: [MorseSymbol]) {
        self.symbols = symbols
    }

    func append(symbol: MorseSymbol) {
        symbols.append(symbol)
    }

    func clear() {
        symbols = []
    }
}