//
//  ImageViewerViewController.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController, ImageViewerViewControllerProtocol {

    var viewModel: ImageViewerViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeViewModelState()
        viewModel?.loadImage()
    }
    
    private func observeViewModelState() {
        viewModel?.onChangeState = { [weak self] state in
            guard let sSelf = self else { return }
            
            DispatchQueue.main.async {
                switch state {
                case let .success(image):
                    sSelf.imageView.image = image
                    sSelf.imageView.alpha = 0
                    UIView.animate(withDuration: 0.3, animations: {
                        sSelf.imageView.alpha = 1
                    })
                case let .error(message):
                    sSelf.present(UIAlertController.okAlertController(message: message), animated: true)
                }
            }
        }
    }
    
    @objc private func imageViewDidTap() {
        viewModel?.close()
    }
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewDidTap)))
        }
    }
}
