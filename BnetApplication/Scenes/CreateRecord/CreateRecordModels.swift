//
//  CreateRecordModels.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum CreateRecord {
    enum Model {
        struct Request {
            enum RequestType {
                case passUserText(userText: String)
            }
        }
   
        struct Response {
            enum ResponseType {
                case success
                case failure(error: String)
                case presentLoader
            }
        }
   
        struct ViewModel {
            enum ViewModelData {
                case success
                case displayFailure(error: String)
                case displayLoader
            }
        }
    }
}
