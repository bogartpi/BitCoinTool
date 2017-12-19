//
//  Configuration.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct API {
    static let RateURL = URL(string: "https://blockchain.info/ticker")!
    static let MarketURL = URL(string: "https://api.blockchain.info/charts/market-price?timespan=6months")!
    static let TransactionURL = URL(string: "https://api.blockchain.info/charts/n-transactions?timespan=6months")!
    static let CapitalizationURL = URL(string: "https://api.blockchain.info/charts/market-cap?timespan=6months")!
}

