//
//  DataManger.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 04/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case unknownError
}

final class DataManager {
    
    typealias CurrencyDataCompletion = ([Currency]?, DataManagerError?) -> ()
    typealias MarketDataCompletion = ([Market]?, DataManagerError?) -> ()
    
    static func fetchCurrencyData(_ url: URL, completion: @escaping (CurrencyDataCompletion)) {
        var currenciesFetched = [Currency]()
        if let json = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            do {
                let currenciesData = try decoder.decode([String: Currency].self, from: json)
                for key in currenciesData.keys {
                    guard var currency = currenciesData[key] else { return }
                    currency.name = key
                    currenciesFetched.append(currency)
                }
                
                completion(currenciesFetched, nil)
                
            } catch let err {
                print(err.localizedDescription)
            }
        } else {
            completion(nil, DataManagerError.failedRequest)
        }
    }
    
    static func fetchMarketData(_ urlArray: [URL], completion: @escaping (MarketDataCompletion)) {
        var marketsFetched = [Market]()
        for url in urlArray {
            if let json = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                do {
                    let marketsData = try decoder.decode(Market.self, from: json)
                    marketsFetched.append(marketsData)
                    completion(marketsFetched, nil)
                } catch let err {
                    print(err.localizedDescription)
                }
            } else {
                completion(nil, DataManagerError.failedRequest)
            }
        }
    }

}
