//
//  ImageViewerAssembly.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class ImageViewerAssembly: ImageViewerAssemblyProtocol {
    static func makeModule(imageURL: URL, imageProvider: ImageProviderProtocol) -> UIViewController {
        let vc = ImageViewerViewController(nibName: String(describing: ImageViewerViewController.self), bundle: Bundle.main)
        
        let router = ImageViewerRouter()
        router.view = vc
        
        let viewModel = ImageViewerViewModel(router: router, imageProvider: imageProvider, imageURL: imageURL)
        vc.viewModel = viewModel
        
        return vc
    }
}

