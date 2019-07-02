//
//  GithubSearchRequest.swift
//  something
//
//  Created by Maxim Semenov on 01/07/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct GithubSearchRequest: APIRequest {
    
    typealias Response = GithubSearchResponse
    
    var method: RESTMethod {
        return .get
    }
    
    var url: String {
        return "https://api.github.com/search/users"
    }
    
    let query: String
    
    enum ItunesSearchKeys: String, CodingKey {
        case query = "q"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItunesSearchKeys.self)
        try container.encode(query, forKey: .query)
    }
}
