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
    
    static func fetchCurrencyData(_ url: URL, completion: @escaping (([Currency]?, DataManagerError?) -> Void)) {
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

}
