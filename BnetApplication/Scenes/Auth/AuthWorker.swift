//
//  AuthWorker.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

class AuthService {
    private var response: ServerResponse?
    private var networking: Networking
    private var fetcher: DataFetcher
    
    init() {
        networking = NetworkService()
        fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getSession(completion: @escaping (Response<ResponseData>) -> Void) {
        fetcher.getSession { (response, error) in
            guard let data = response?.data else {
                return completion(.failure(error!.localizedDescription))
            }
            completion(.success(data))
        }
    }
}
