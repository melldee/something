//
//  ImageViewerContract.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

enum ImageViewerState {
    case success(image: UIImage)
    case error(message: String)
}

protocol ImageViewerAssemblyProtocol: class {
    static func makeModule(imageURL: URL, imageProvider: ImageProviderProtocol) -> UIViewController
}

protocol ImageViewerRouterProtocol: class {
    var view: ImageViewerViewControllerProtocol? { get set }
    func dismiss()
}

protocol ImageViewerViewModelProtocol: class {
    var onChangeState: ((ImageViewerState) -> Void)? { get set }
    func loadImage()
    func close()
}

protocol ImageViewerViewControllerProtocol: class {
    var viewModel: ImageViewerViewModelProtocol? { get set }
}
