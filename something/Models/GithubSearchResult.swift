//
//  GithubSearchResult.swift
//  something
//
//  Created by Maxim Semenov on 01/07/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

struct GithubSearchResult: Decodable {
    
    let login: String?
    let url: String
    let avatarURL: URL?
    
    enum GithubSearchResultKeys: String, CodingKey {
        case login
        case url = "html_url"
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GithubSearchResultKeys.self)
        self.login = try? container.decode(String.self, forKey: .login)
        self.url = try container.decode(String.self, forKey: .url)
        self.avatarURL = URL(string: (try container.decode(String.self, forKey: .avatarURL)))
    }
}
