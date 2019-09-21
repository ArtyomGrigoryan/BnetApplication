//
//  AuthInteractor.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthBusinessLogic {
    func makeRequest(request: Auth.Model.Request.RequestType)
}

protocol AuthDataStore {
    var session: String? { get }
}

class AuthInteractor: AuthBusinessLogic, AuthDataStore {

    // MARK: - Public variables
    
    var session: String?
    var service: AuthService?
    var presenter: AuthPresentationLogic?
  
    // MARK: - AuthBusinessLogic
    
    func makeRequest(request: Auth.Model.Request.RequestType) {
        if service == nil {
            service = AuthService()
        }
        
        switch request {
        case .getSession:
            presenter?.presentData(response: .presentLoader)
            service?.getSession { [weak self] (response) in
                switch response {
                case .success(let data):
                    self?.session = data.session
                    self?.presenter?.presentData(response: .success)
                case .failure(let error):
                    self?.presenter?.presentData(response: .failure(error: error))
                }
            }
        }
    }
}
