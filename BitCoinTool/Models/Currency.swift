//
//  CurrencyData.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

enum CurrencyNames: String {
    case USD = "United States Dollar"
    case EUR = "European Union Euro"
    case NZD = "New Zealand Dollar"
    case TWD = "New Taiwan Dollar"
    case HKD = "Hong Kong Dollar"
    case ISK = "Icelandic Krona"
    case CAD = "Canadian Dollar"
    case DKK = "Danish Krone"
    case KRW = "Korea Republic Won"
    case GBP = "The British Pound"
    case INR = "Indian Rupee"
    case CHF = "Swiss Franc"
    case PLN = "Poland Zloty"
    case CNY = "Chinese Yuan"
    case THB = "Thailand Baht"
    case CLP = "Chilean Peso"
    case BRL = "Brazilian Real"
    case RUB = "Russian Ruble"
    case SEK = "Swedish Krona"
    case AUD = "Australian Dollar"
    case SGD = "Singapore Dollar"
    case JPY = "Japanese Yen"
}

struct Currency: Decodable {
    
    var name = ""
    let fifteenMin: Double?
    let last: Double?
    let buy: Double
    let sell: Double
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case fifteenMin = "15m"
        case last
        case buy
        case sell
        case symbol
    }
}

