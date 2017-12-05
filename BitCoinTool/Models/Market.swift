//
//  Market.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

struct Market: Codable {
    
    let name: String
    let unit: String
    let description: String
    let values: [Value]
}

struct Value: Codable {
    
    var date: Double
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "x"
        case price = "y"
    }
}
