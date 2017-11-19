//
//  JSONDecodable.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init(decoder: JSONDecoder) throws
}

enum JSONDecoderError: Error {
    case invalidData
    case keyNotFound(String)
    case keyPathNotFound(String)
}

struct JSONDecoder {
    
    typealias JSON = [String: AnyObject]
    
    // MARK: - Properties
    
    private let JSONData: JSON
    
    // MARK: - Initializer
    
    init(data: Data) throws {
        if let JSONData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
            self.JSONData = JSONData
        } else {
            throw JSONDecoderError.invalidData
        }
    }
    
    // MARK: - Static Methods
    
    static func decode<T: JSONDecodable>(data: Data) throws -> T {
        let decoder = try JSONDecoder(data: data)
        return try T(decoder: decoder)
    }
    
    private init(JSONData: JSON) {
        self.JSONData = JSONData
    }
    
    func decode<T>(key: String) throws -> T {
        
        guard let value: T = try? value(forKey: key) else {
            throw JSONDecoderError.keyNotFound(key)
        }
        return value
    }
    
    private func value<T>(forKey key: String) throws -> T {
        guard let value = JSONData[key] as? T else {
            throw JSONDecoderError.keyNotFound(key)
        }
        return value
    }
}
