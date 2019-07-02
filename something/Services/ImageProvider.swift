//
//  ImageProvider.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

protocol ImageProviderProtocol: class {
    func image(url: String, completion: @escaping (Result<UIImage>) -> Void)
}

class ImageProvider: ImageProviderProtocol {
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func image(url: String, completion: @escaping (Result<UIImage>) -> Void) {
        if let image = self.imageCache[url] {
            completion(.success(image))
        }
        
        apiClient.download(url: URL(string: url)!) { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(data):
                if let image = UIImage(data: data) {
                    sSelf.imageCache[url] = image
                    completion(.success(image))
                }
            case let .failure(error):
                print("Image Download error: \(error.localizedDescription)")
            }
        }
    }
    
    private var imageCache: [String: UIImage] = [:]
    
    private let apiClient: APIClientProtocol
}
