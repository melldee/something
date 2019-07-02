//
//  ItunesSearchRequest.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct ItunesSearchRequest: APIRequest {
    
    typealias Response = ItunesSearchResponse
    
    var method: RESTMethod {
        return .get
    }
    
    var url: String {
        return "https://itunes.apple.com/search"
    }
    
    let query: String
    
    enum ItunesSearchKeys: String, CodingKey {
        case query = "term"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItunesSearchKeys.self)
        try container.encode(query, forKey: .query)
    }
}
