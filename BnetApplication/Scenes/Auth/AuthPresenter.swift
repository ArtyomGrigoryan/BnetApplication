//
//  AuthPresenter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthPresentationLogic {
    func presentData(response: Auth.Model.Response.ResponseType)
}

class AuthPresenter: AuthPresentationLogic {
    
    // MARK: - Public variables
    
    weak var viewController: AuthDisplayLogic?
  
    // MARK: - SearchPhotosPresentationLogic
    
    func presentData(response: Auth.Model.Response.ResponseType) {
        switch response {
        case .success:
            viewController?.displayData(viewModel: .success)
        case .failure(let error):
            viewController?.displayData(viewModel: .displayFailure(errorTitle: error))
        case .presentLoader:
            viewController?.displayData(viewModel: .displayLoader)
        }
    }
}
