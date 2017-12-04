//
//  DataManger.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 04/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
}

final class DataManager {
    
    typealias CurrencyDataCompletion = (Currency?, DataManagerError?) -> ()
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    static func fetchCurrencyData(_ url: URL, callback: @escaping (([Currency]) -> Void)) {
        
        var currenciesFetched = [Currency]()
        
        let json = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        do {
            let currenciesData = try decoder.decode([String: Currency].self, from: json)
            for key in currenciesData.keys {
                guard var currency = currenciesData[key] else { return }
                currency.name = key
                currenciesFetched.append(currency)
            }
            
            callback(currenciesFetched)
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    
}
