//
//  ItunesSearchResult.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct ItunesSearchResult: Decodable {
    
    let name: String?
    let author: String
    let avatarURL: URL?
    
    enum ItunesSearchResultKeys: String, CodingKey {
        case name = "trackName"
        case author = "artistName"
        case avatarURL = "artworkUrl100"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItunesSearchResultKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.author = try container.decode(String.self, forKey: .author)
        self.avatarURL = URL(string: (try container.decode(String.self, forKey: .avatarURL)))
    }
}
