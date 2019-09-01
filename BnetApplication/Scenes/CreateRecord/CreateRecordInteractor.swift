//
//  CreateRecordInteractor.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordBusinessLogic {
    func makeRequest(request: CreateRecord.Model.Request.RequestType)
}

protocol CreateRecordDataStore {
    var session: String? { get set }
}

class CreateRecordInteractor: CreateRecordBusinessLogic, CreateRecordDataStore {
    
    // MARK: - Public variables
    
    var session: String?
    var service: CreateRecordService?
    var presenter: CreateRecordPresentationLogic?
  
    // MARK: - CreateRecordBusinessLogic
    
    func makeRequest(request: CreateRecord.Model.Request.RequestType) {
        if service == nil {
            service = CreateRecordService()
        }

        guard let service = service, let session = session else { return }
        
        switch request {
        case .passUserText(let userText):
            service.createNewRecord(session: session, userText: userText) { [weak self] (dataResponse) in
                switch dataResponse {
                case .success:
                    self?.presenter?.presentData(response: .success)
                case .failure(let error):
                    self?.presenter?.presentData(response: .failure(error: error))
                }
            }
        }
    }
}
