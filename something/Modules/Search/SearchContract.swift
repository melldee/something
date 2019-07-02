//
//  SearchContract.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

enum SearchServiceType: Int, CaseIterable {
    case itunes = 0
    case github
    
    var title: String {
        switch self {
        case .itunes:
            return "itunes"
        case .github:
            return "github"
        }
    }
}

protocol SearchAssemblyProtocol: class {
    static func makeModule() -> UIViewController
}

protocol SearchRouterProtocol: class {
    var view: SearchViewControllerProtocol? { get set }
}

protocol SearchViewModelProtocol: class {
    
}

protocol SearchViewControllerProtocol: class {
    var viewModel: SearchViewModelProtocol? { get set }
}
