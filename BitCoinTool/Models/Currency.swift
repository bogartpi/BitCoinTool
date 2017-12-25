//
//  CurrencyData.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

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

