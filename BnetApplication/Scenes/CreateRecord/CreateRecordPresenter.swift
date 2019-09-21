//
//  CreateRecordPresenter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordPresentationLogic {
    func presentData(response: CreateRecord.Model.Response.ResponseType)
}

class CreateRecordPresenter: CreateRecordPresentationLogic {
    
    // MARK: - Public variables
    
    weak var viewController: CreateRecordDisplayLogic?
  
    // MARK: - CreateRecordPresentationLogic
    
    func presentData(response: CreateRecord.Model.Response.ResponseType) {
        switch response {
        case .success:
            viewController?.displayData(viewModel: .success)
        case .failure(let error):
            viewController?.displayData(viewModel: .displayFailure(error: error))
        case .presentLoader:
            viewController?.displayData(viewModel: .displayLoader)
        }
    }
}
