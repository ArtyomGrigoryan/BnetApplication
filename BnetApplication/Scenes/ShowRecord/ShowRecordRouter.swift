//
//  ShowRecordRouter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 01/09/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordRoutingLogic {

}

protocol ShowRecordDataPassing {
    var dataStore: ShowRecordDataStore? { get }
}

class ShowRecordRouter: NSObject, ShowRecordRoutingLogic, ShowRecordDataPassing {

    // MARK: - Public variables
    
    var dataStore: ShowRecordDataStore?
    weak var viewController: ShowRecordViewController?
  
}
