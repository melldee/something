//
//  SearchAssembly.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchAssembly: SearchAssemblyProtocol {
    static func makeModule() -> UIViewController {
        let vc = SearchViewController(nibName: String(describing: SearchViewController.self), bundle: Bundle.main)
        
        if let itunesSearchResultViewController = SearchResultAssembly.makeModule(type: .itunes) as? SearchResultViewController {
            vc.itunesSearchResultViewController = itunesSearchResultViewController
        }
        
        if let githubSearchResultViewController = SearchResultAssembly.makeModule(type: .github) as? SearchResultViewController {
            vc.githubSearchResultViewController = githubSearchResultViewController
        }
        
        let router = SearchRouter()
        router.view = vc
        
        let viewModel = SearchViewModel()
        vc.viewModel = viewModel
        
        return vc
    }
}
