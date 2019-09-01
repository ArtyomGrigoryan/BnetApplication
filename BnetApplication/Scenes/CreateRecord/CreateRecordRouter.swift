//
//  CreateRecordRouter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

@objc protocol CreateRecordRoutingLogic {
    
}

protocol CreateRecordDataPassing {
    var dataStore: CreateRecordDataStore? { get }
}

class CreateRecordRouter: NSObject, CreateRecordRoutingLogic, CreateRecordDataPassing {

    // MARK: - Public variables
    
    var dataStore: CreateRecordDataStore?
    weak var viewController: CreateRecordViewController?
    
}
