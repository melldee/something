//
//  APIClient.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

class APIClient: APIClientProtocol {
    
    @discardableResult
    func send<T: APIRequest>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) -> URLSessionTask {
        let urlRequest: URLRequest? = try? prepareRequest(request)
        
        guard let urlAPIRequest = urlRequest else {
            fatalError("Error while preparing url request for \(request)")
        }
        
        let task = URLSession.shared.dataTask(with: urlAPIRequest) { (data, response, error) in
            if let data = data {
                do {
                    let encoded = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(encoded))
                    
                } catch let decodeError {
                    print(decodeError)
                    completion(.failure(APIError.decoding))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
        
        return task
    }
    
    @discardableResult
    func download(url: URL, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = RESTMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
        
        return task
    }
    
    private func prepareRequest<T: APIRequest>(_ request: T) throws -> URLRequest {
        if request.method == .get {
            let url = endpoint(for: request)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            
            return urlRequest
        }
        
        fatalError("can't prepare request exclude GET")
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        var urlPath = request.url
        if let parameters = try? URLQueryEncoder.encode(request) {
            urlPath += "?\(parameters)"
        }
        
        return URL(string: urlPath)!
    }
}
