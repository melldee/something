//
//  SearchResultAssembly.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchResultAssembly: SearchResultAssemblyProtocol {
    static func makeModule(type: SearchResultType) -> UIViewController {
        let vc = SearchResultViewController(nibName: String(describing: SearchResultViewController.self), bundle: Bundle.main)
        
        let router = SearchResultRouter()
        router.view = vc
        
        let apiClient = APIClient()
        let viewModel = SearchResultViewModel(router: router, apiClient: apiClient, imageProvider: ImageProvider(apiClient: apiClient), type: type)
        vc.viewModel = viewModel
        
        return vc
    }
}
