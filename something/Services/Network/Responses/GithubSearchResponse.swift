//
//  GithubSearchResponse.swift
//  something
//
//  Created by Maxim Semenov on 01/07/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct GithubSearchResponse: Decodable {
    
    let results: [GithubSearchResult]
    
    enum GithubSearchKeys : String, CodingKey {
        case results = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GithubSearchKeys.self)
        self.results = try container.decode([GithubSearchResult].self, forKey: .results)
    }
}
