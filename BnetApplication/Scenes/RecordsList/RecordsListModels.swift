//
//  RecordsListModels.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum RecordsList {
    enum Model {
        struct Request {
            enum RequestType {
                case getRecords
            }
        }
    
        struct Response {
            enum ResponseType {
                case presentLoader
                case presentError(error: String)
                case presentResponseData(records: [ResponseData2])
            }
        }
 
        struct ViewModel {
            enum ViewModelData {
                case displayLoader
                case displayError(error: String)
                case displayRecords(viewModel: RecordsViewModel)
            }
        }
    }
}

struct RecordsViewModel {
    struct Cell: RecordsListCellViewModel {
        var body: String
        var da: Date
        var dm: Date
    }
    
    let cells: [Cell]
}
