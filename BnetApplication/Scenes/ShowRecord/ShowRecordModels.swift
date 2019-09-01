//
//  ShowRecordModels.swift
//  BnetApplication
//
//  Created by Артем Григорян on 01/09/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum ShowRecord {
    enum Model {
        struct Request {
            enum RequestType {
                case getRecord
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentResponseData(records: ResponseData2)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayRecord(recordBody: String)
            }
        }
    }
}
