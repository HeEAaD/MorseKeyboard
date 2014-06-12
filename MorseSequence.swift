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

    var symbols : MorseSymbol[]

    var description: String {
        return symbols.reduce("") { $0 + $1.toRaw() }
    }

    var intepretation : Character? {
        switch description {
            case "·−"  : return "A"
            case "−···": return "B"
            case "·"   : return "E"
            case "···" : return "S"
            case "−−−" : return "O"
            default:
                return nil
        }
    }

    init() {
        symbols = []
    }

    init(symbols: MorseSymbol[]) {
        self.symbols = symbols
    }

    func append(symbol: MorseSymbol) {
        symbols.append(symbol)
    }

    func clear() {
        symbols = []
    }
}