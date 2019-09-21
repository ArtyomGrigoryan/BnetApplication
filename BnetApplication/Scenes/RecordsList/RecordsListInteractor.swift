//
//  RecordsListInteractor.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListBusinessLogic {
    func makeRequest(request: RecordsList.Model.Request.RequestType)
}

protocol RecordsListDataStore {
    var session: String? { get set }
    var records: [ResponseData2]? { get }
}

class RecordsListInteractor: RecordsListBusinessLogic, RecordsListDataStore {

    // MARK: - Public variables
    
    var session: String?
    var records: [ResponseData2]?
    var service: RecordsListService?
    var presenter: RecordsListPresentationLogic?

    // MARK: - RecordsListBusinessLogic
    
    func makeRequest(request: RecordsList.Model.Request.RequestType) {
        if service == nil {
            service = RecordsListService()
        }
        
        guard let session = session else { return }
        
        switch request {
        case .getRecords:
            presenter?.presentData(response: .presentLoader)
            service?.getRecords(session: session) { [weak self] (dataResponse) in
                switch dataResponse {
                case .success(let response):
                    self?.records = response
                    self?.presenter?.presentData(response: .presentResponseData(records: response))
                case .failure(let error):
                    self?.presenter?.presentData(response: .presentError(error: error))
                }
            }
        }
    }
}
