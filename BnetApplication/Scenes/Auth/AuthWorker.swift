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
    private var fetcherService: DataFetcherService!
    
    init() {
        fetcherService = DataFetcherService()
    }
    
    func getSession(completion: @escaping (Response<ResponseData>) -> Void) {
        fetcherService.getSession { (response, error) in
            // Отсутствует интернет-соединение.
            if let error = error {
                completion(.failure(error.localizedDescription))
            // Другая ошибка, указанная в разделе "Примеры ошибок" на сайте https://bnet.i-partner.ru/testAPI/
            } else if response?.status == 0 {
                completion(.failure(response!.error!))
            // Отсутствие ошибок.
            } else {
                completion(.success(response!.data!))
            }
        }
    }
}
