//
//  DataManager.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 19/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
}

class DataManager {
    
    typealias CurrencyDataCompletion = (CurrencyData?, DataManagerError?) -> ()
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getCurrencyDataWithCode(currencyCode: String, completion: @escaping CurrencyDataCompletion) {
        // Create URL
        let url = baseURL.appendingPathComponent("\(currencyCode).json")
        
        // Create Data Task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFetchCurrencyData(data: data, response: response, error: error, completion: completion)
            }
        }.resume()
    }
    
    private func didFetchCurrencyData(data: Data?, response: URLResponse?, error: Error?, completion: CurrencyDataCompletion) {
        if let _ = error {
            completion(nil, DataManagerError.failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    // Decode Json
                    let currencyData: CurrencyData = try JSONDecoder.decode(data: data)
                    completion(currencyData, nil)
                } catch {
                    completion(nil, DataManagerError.invalidResponse)
                }
            } else {
                completion(nil, DataManagerError.failedRequest)
            }
        } else {
            completion(nil, DataManagerError.unknown)
        }
    }
    
}














