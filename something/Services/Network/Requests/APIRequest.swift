//
//  APIRequest.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

enum RESTMethod: String {
    case get = "GET"
}

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var method: RESTMethod { get }
    var url: String { get }
}
