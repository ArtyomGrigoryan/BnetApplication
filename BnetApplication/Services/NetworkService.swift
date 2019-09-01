//
//  NetworkService.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol Networking {
    func request(params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    func request(params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let url = constructURL(with: params).url else { return }
        var request = URLRequest(url: url)
        
        if let query = url.query {
            request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue(API.token, forHTTPHeaderField: "token");
            request.httpBody = query.data(using: .utf8)
            request.httpMethod = "POST"
        }
          
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
 
    private func constructURL(with params: [String: String]) -> URLComponents {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
}
