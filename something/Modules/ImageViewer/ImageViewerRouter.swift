//
//  ImageViewerRouter.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class ImageViewerRouter: ImageViewerRouterProtocol {
    weak var view: ImageViewerViewControllerProtocol?
    
    func dismiss() {
        (view as? UIViewController)?.dismiss(animated: true)
    }
}
