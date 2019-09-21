//
//  RecordsListPresenter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListPresentationLogic {
    func presentData(response: RecordsList.Model.Response.ResponseType)
}

class RecordsListPresenter: RecordsListPresentationLogic {
  
    // MARK: - Public variables
    
    weak var viewController: RecordsListDisplayLogic?
  
    // MARK: - RecordsListPresentationLogic
    
    func presentData(response: RecordsList.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let records):
            let cells = records.map { cellViewModel(from: $0) }
            
            let recordsViewModel = RecordsViewModel(cells: cells)
            
            viewController?.displayData(viewModel: .displayRecords(viewModel: recordsViewModel))
        case .presentError(let error):
            viewController?.displayData(viewModel: .displayError(error: error))
        case .presentLoader:
            viewController?.displayData(viewModel: .displayLoader)
        }
    }
    
    private func cellViewModel(from record: ResponseData2) -> RecordsViewModel.Cell {
        let maxLength = 200
        let convertedDaDate = Date(timeIntervalSince1970: Double(record.da)!)
        let convertedDmDate = Date(timeIntervalSince1970: Double(record.dm)!)
        var body = record.body
        
        if body.count > maxLength {
            let range = body.rangeOfComposedCharacterSequences(for: body.startIndex..<body.index(body.startIndex, offsetBy: maxLength))
            body = String(body[range]).appending("...")
        }
        
        return RecordsViewModel.Cell(body: body, da: convertedDaDate, dm: convertedDmDate)
    }
}
