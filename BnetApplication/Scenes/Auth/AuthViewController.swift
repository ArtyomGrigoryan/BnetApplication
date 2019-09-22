//
//  AuthViewController.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthDisplayLogic: class {
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData)
}

class AuthViewController: UIViewController, AuthDisplayLogic {

    // MARK: - Public variables
    
    var interactor: AuthBusinessLogic?
    var router: (NSObjectProtocol & AuthRoutingLogic & AuthDataPassing)?
    
    // MARK: - @IBOutlets

    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = AuthInteractor()
        let presenter             = AuthPresenter()
        let router                = AuthRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    private func setupUI() {
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
    }
  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.makeRequest(request: .getSession)
    }
  
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .success:
            hideActivityIndicator()
            router?.routeToRecordsList(segue: nil)
        case .displayFailure(let errorTitle):
            hideActivityIndicator()
            errorAlert(with: errorTitle)
        case .displayLoader:
            showActivityIndicator()
        }
    }
  
    // MARK: - UI
    
    private func errorAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
        let tryAgainAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (_) in
            guard let self = self, let interactor = self.interactor else { return }
            interactor.makeRequest(request: .getSession)
        }
        
        alertController.addAction(tryAgainAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    private func showActivityIndicator() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
}
