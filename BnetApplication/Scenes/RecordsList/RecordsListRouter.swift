//
//  RecordsListRouter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

@objc protocol RecordsListRoutingLogic {
    func routeToCreateRecord(segue: UIStoryboardSegue)
    func routeToShowRecord(segue: UIStoryboardSegue)
}

protocol RecordsListDataPassing {
    var dataStore: RecordsListDataStore? { get }
}

class RecordsListRouter: NSObject, RecordsListRoutingLogic, RecordsListDataPassing {

    // MARK: - Public variables
    
    var dataStore: RecordsListDataStore?
    weak var viewController: RecordsListViewController?
  
    // MARK: - Routing
    
    func routeToCreateRecord(segue: UIStoryboardSegue) {
        let nvc = segue.destination as! UINavigationController
        let dvc = nvc.topViewController as! CreateRecordViewController
        var destinationDS = dvc.router!.dataStore!
        passDataToCreateRecord(source: dataStore!, destination: &destinationDS)
    }
    
    func passDataToCreateRecord(source: RecordsListDataStore, destination: inout CreateRecordDataStore) {
        destination.session = source.session
    }
  
    func routeToShowRecord(segue: UIStoryboardSegue) {
        let dvc = segue.destination as! ShowRecordViewController
        var destinationDS = dvc.router!.dataStore!
        passDataToShowRecord(source: dataStore!, destination: &destinationDS)
    }
    
    func passDataToShowRecord(source: RecordsListDataStore, destination: inout ShowRecordDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.record = source.records![selectedRow!]
    }
}
