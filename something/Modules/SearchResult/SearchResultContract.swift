//
//  SearchResultContract.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

enum SearchResultType {
    case itunes
    case github
}

enum SearchResultState {
    case loading
    case success
    case error(message: String)
}

protocol SearchResultAssemblyProtocol: class {
    static func makeModule(type: SearchResultType) -> UIViewController
}

protocol SearchResultRouterProtocol: class {
    var view: SearchResultViewControllerProtocol? { get set }
    func showImage(imageURL: URL, imageProvider: ImageProviderProtocol, initialFrame: CGRect)
}

protocol SearchResultViewModelProtocol: class {
    var onChangeState: ((SearchResultState) -> Void)? { get set }
    var results: [SearchResultTableViewCellViewModel] { get }
    func search(query: String)
    func resetSearch()
}

protocol SearchResultViewControllerProtocol: class {
    var viewModel: SearchResultViewModelProtocol? { get set }
    func search(query: String)
    func resetSearch()
}
