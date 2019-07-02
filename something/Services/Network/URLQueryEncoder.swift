//
//  URLQueryEncoder.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

enum HTTPParameter: Decodable {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
    case intArray([Int])
    
    var stringValue: String {
        switch self {
        case .string(let value):
            return String(value)
        case .bool(let value):
            return String(value)
        case .int(let value):
            return String(value)
        case .double(let value):
            return String(value)
        case .intArray(let value):
            return value.map(String.init).joined(separator: ",")
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
            
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let arrayInt = try? container.decode([Int].self) {
            self = .intArray(arrayInt)
        } else {
            throw APIError.decoding
        }
    }
}

class URLQueryEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        return parameters
            .map({ "\($0)=\($1.stringValue)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
