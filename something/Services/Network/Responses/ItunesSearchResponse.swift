//
//  ItunesSearchResponse.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct ItunesSearchResponse: Decodable {
    
    let results: [ItunesSearchResult]
    
    enum ItunesSearchKeys : String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItunesSearchKeys.self)
        self.results = try container.decode([ItunesSearchResult].self, forKey: .results)
    }
}
