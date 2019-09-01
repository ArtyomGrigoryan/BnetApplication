//
//  ShowRecordPresenter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 01/09/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordPresentationLogic {
    func presentData(response: ShowRecord.Model.Response.ResponseType)
}

class ShowRecordPresenter: ShowRecordPresentationLogic {
    
    // MARK: - Public variables
    
    weak var viewController: ShowRecordDisplayLogic?
  
    // MARK: - ShowRecordPresentationLogic
    
    func presentData(response: ShowRecord.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let record):
            viewController?.displayData(viewModel: .displayRecord(recordBody: record.body))
        }
    }
}
