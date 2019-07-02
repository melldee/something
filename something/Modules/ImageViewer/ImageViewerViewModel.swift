//
//  ImageViewerViewModel.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

class ImageViewerViewModel: ImageViewerViewModelProtocol {
    
    init(router: ImageViewerRouterProtocol, imageProvider: ImageProviderProtocol, imageURL: URL) {
        self.router = router
        self.imageProvider = imageProvider
        self.imageURL = imageURL
    }
    
    var onChangeState: ((ImageViewerState) -> Void)?
    
    func loadImage() {
        imageProvider.image(url: imageURL.absoluteString) { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(image):
                sSelf.onChangeState?(.success(image: image))
            case let .failure(error):
                sSelf.onChangeState?(.error(message: error.localizedDescription))
            }
        }
    }
    
    func close() {
        router.dismiss()
    }
    
    private(set) var results: [SearchResultTableViewCellViewModel] = []
    
    private let router: ImageViewerRouterProtocol
    private let imageProvider: ImageProviderProtocol
    private let imageURL: URL
}

