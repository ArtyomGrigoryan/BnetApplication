//
//  AuthModels.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum Auth {
    enum Model {
        struct Request {
            enum RequestType {
                case getSession
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
                case presentFailure(errorTitle: String)
                case displayLoader
            }
        }
    }
}
