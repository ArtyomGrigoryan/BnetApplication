//
//  AuthRouter.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthRoutingLogic {
    func routeToRecordsList(segue: UIStoryboardSegue?)
}

protocol AuthDataPassing {
    var dataStore: AuthDataStore? { get }
}

class AuthRouter: NSObject, AuthRoutingLogic, AuthDataPassing  {
    
    // MARK: - Public variables
    
    var dataStore: AuthDataStore?
    weak var viewController: AuthViewController?
  
    // MARK: - Routing
  
    func routeToRecordsList(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecordsListViewController") as! RecordsListViewController
        let destinationNavigationVC = UINavigationController(rootViewController: vc)
        destinationNavigationVC.modalPresentationStyle = .fullScreen
        var destinationDS = vc.router!.dataStore!
        passDataToRecordsList(source: self.dataStore!, destination: &destinationDS)
        navigateToRecordsList(source: self.viewController!, destination: destinationNavigationVC)
    }
    
    func passDataToRecordsList(source: AuthDataStore, destination: inout RecordsListDataStore) {
        destination.session = source.session
    }
    
    func navigateToRecordsList(source: AuthViewController, destination: UINavigationController) {
        source.show(destination, sender: nil)
    }
}
