//
//  ShowRecordInteractor.swift
//  BnetApplication
//
//  Created by Артем Григорян on 01/09/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordBusinessLogic {
    func makeRequest(request: ShowRecord.Model.Request.RequestType)
}

protocol ShowRecordDataStore {
    var record: ResponseData2? { get set }
}

class ShowRecordInteractor: ShowRecordBusinessLogic, ShowRecordDataStore {

    // MARK: - Public variables
    
    var record: ResponseData2?
    var presenter: ShowRecordPresentationLogic?
  
    // MARK: - ShowRecordBusinessLogic
    
    func makeRequest(request: ShowRecord.Model.Request.RequestType) {
        switch request {
        case .getRecord:
            self.presenter?.presentData(response: .presentResponseData(records: self.record!))
        }
    }
}
