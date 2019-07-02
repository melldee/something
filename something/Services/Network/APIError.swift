//
//  APIError.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case encoding
    case decoding
    case server(message: String)
}
