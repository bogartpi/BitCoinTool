//
//  CurrencyData.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

struct CurrencyData {

    let timeUpdated: Date
    
    let rate: String
    let currencyCode: String
    let currencyDescription: String
    
}

extension CurrencyData: JSONDecodable {
    
    init(decoder: JSONDecoder) throws {
        self.rate = try decoder.decode(key: "rate")
        self.currencyCode = try decoder.decode(key: "code")
        self.currencyDescription = try decoder.decode(key: "description")
        
        let time: Double = try decoder.decode(key: "updated")
        self.timeUpdated = Date(timeIntervalSince1970: time)
    }
    
}
