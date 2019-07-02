//
//  SearchResultRouter.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchResultRouter: SearchResultRouterProtocol {
    weak var view: SearchResultViewControllerProtocol?
    
    func showImage(imageURL: URL, imageProvider: ImageProviderProtocol, initialFrame: CGRect) {
        let vc = ImageViewerAssembly.makeModule(imageURL: imageURL, imageProvider: imageProvider)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = zoomAnimator
        
        if let searchResultViewController = view as? SearchResultViewController {
            zoomAnimator.initialFrame = initialFrame
            searchResultViewController.present(vc, animated: true)
        }
    }
    
    private let zoomAnimator: ZoomAnimator = ZoomAnimator()
}
