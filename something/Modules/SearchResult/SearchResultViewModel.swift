//
//  SearchResultViewModel.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

class SearchResultViewModel: SearchResultViewModelProtocol {
    
    init(router: SearchResultRouterProtocol, apiClient: APIClientProtocol, imageProvider: ImageProviderProtocol, type: SearchResultType) {
        self.router = router
        self.apiClient = apiClient
        self.imageProvider = imageProvider
        self.type = type
    }
    
    var onChangeState: ((SearchResultState) -> Void)?
    
    func search(query: String) {
        onChangeState?(.loading)
        switch type {
        case .itunes:
           itunesSearch(query: query)
        case .github:
           githubSearch(query: query)
        }
    }
    
    func resetSearch() {
        results = []
        onChangeState?(.success)
    }
    
    private func itunesSearch(query: String) {
        let itunesSearchRequest = ItunesSearchRequest(query: query)
        apiClient.send(itunesSearchRequest) { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(data):
                sSelf.results = data.results.map { resultData in
                    let viewModel = SearchResultTableViewCellViewModel(name: resultData.name, author: resultData.author, imageURL: resultData.avatarURL)
                    viewModel.onNeedToDownloadImage = { [weak self] url in
                        guard let sSelf = self else { return }
                        
                        sSelf.imageProvider.image(url: url, completion: { result in
                            DispatchQueue.main.async {
                                switch result {
                                case let .success(image):
                                    viewModel.onSuccessDownloadImage?(image)
                                case .failure:
                                    print("Error when download image")
                                }
                            }
                        })
                    }
                    viewModel.onTapImage = { [weak self] in
                        guard let sSelf = self, let imageURL = viewModel.imageURL  else { return }
                        
                        sSelf.router.showImage(imageURL: imageURL, imageProvider: sSelf.imageProvider, initialFrame: viewModel.onSetInitialFrame?() ?? .zero)
                    }
                    
                    return viewModel
                }
                sSelf.onChangeState?(.success)
            case let .failure(error):
                sSelf.onChangeState?(.error(message: error.localizedDescription))
            }
        }
    }
    
    private func githubSearch(query: String) {
        let githubSearchRequest = GithubSearchRequest(query: query)
        apiClient.send(githubSearchRequest) { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(data):
                sSelf.results = data.results.map { resultData in
                    let viewModel = SearchResultTableViewCellViewModel(name: resultData.login, author: resultData.url, imageURL: resultData.avatarURL)
                    viewModel.onNeedToDownloadImage = { [weak self] url in
                        guard let sSelf = self else { return }
                        
                        sSelf.imageProvider.image(url: url, completion: { result in
                            DispatchQueue.main.async {
                                switch result {
                                case let .success(image):
                                    viewModel.onSuccessDownloadImage?(image)
                                case .failure:
                                    print("Error when download image")
                                }
                            }
                        })
                    }
                    viewModel.onTapImage = { [weak self] in
                        guard let sSelf = self, let imageURL = viewModel.imageURL  else { return }
                        
                        sSelf.router.showImage(imageURL: imageURL, imageProvider: sSelf.imageProvider, initialFrame: viewModel.onSetInitialFrame?() ?? .zero)
                    }
                    
                    return viewModel
                }
                sSelf.onChangeState?(.success)
            case let .failure(error):
                sSelf.onChangeState?(.error(message: error.localizedDescription))
            }
        }
    }
    
    private(set) var results: [SearchResultTableViewCellViewModel] = []
    
    private let type: SearchResultType
    private let apiClient: APIClientProtocol
    private let imageProvider: ImageProviderProtocol
    private let router: SearchResultRouterProtocol
}
