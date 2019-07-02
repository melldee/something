//
//  SearchResultTableViewCellViewModel.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchResultTableViewCellViewModel {
    
    let name: String?
    let author: String
    let imageURL: URL?
    
    var onNeedToDownloadImage: ((String) -> Void)?
    var onSuccessDownloadImage: ((UIImage) -> Void)?
    var onTapImage: (() -> Void)?
    var onSetInitialFrame: (() -> CGRect)?
    
    init(name: String? = nil, author: String, imageURL: URL? = nil) {
        self.name = name
        self.author = author
        self.imageURL = imageURL
    }
}
