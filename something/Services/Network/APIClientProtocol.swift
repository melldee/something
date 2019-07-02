//
//  APIClientProtocol.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    @discardableResult
    func send<T: APIRequest>( _ request: T, completion: @escaping (Result<T.Response>) -> Void) -> URLSessionTask
    @discardableResult
    func download(url: URL, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask
}
