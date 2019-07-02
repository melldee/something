//
//  SearchResultTableViewCell.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        valueTextView.textContainerInset = .zero
        valueTextView.textContainer.lineFragmentPadding = 0
    }

    func setUp(viewModel: SearchResultTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        valueTextView.text = viewModel.author
        avatarImageView.image = nil
        onTapImage = viewModel.onTapImage
        
        if let imageURL = viewModel.imageURL {
            viewModel.onNeedToDownloadImage?(imageURL.absoluteString)
            viewModel.onSuccessDownloadImage = { [weak self] image in
                guard let sSelf = self else { return }
                
                sSelf.avatarImageView.image = image
                sSelf.avatarImageView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    sSelf.avatarImageView.alpha = 1
                })
            }
        }
    }
    
    @objc private func avatarImageViewDidTap() {
        onTapImage?()
    }
    
    private var onTapImage: (() -> Void)?
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarImageViewDidTap)))
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueTextView: UITextView!
}
