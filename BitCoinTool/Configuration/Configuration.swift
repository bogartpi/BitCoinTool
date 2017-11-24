//
//  Configuration.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct API {
    
    static let BaseURL = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/")!
    static let currencyKey = "nzd"
    
    static var builtBaseUrl: URL {
        return BaseURL.appendingPathComponent(currencyKey)
    }
}

