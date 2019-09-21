//
//  CreateRecordViewController.swift
//  BnetApplication
//
//  Created by Артем Григорян on 23/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordDisplayLogic: class {
    func displayData(viewModel: CreateRecord.Model.ViewModel.ViewModelData)
}

class CreateRecordViewController: UIViewController, CreateRecordDisplayLogic {

    // MARK: - Public variables
    
    var interactor: CreateRecordBusinessLogic?
    var router: (NSObjectProtocol & CreateRecordRoutingLogic & CreateRecordDataPassing)?

    // MARK: - Private variables
    
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var textArea: UITextView!
    
    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = CreateRecordInteractor()
        let presenter             = CreateRecordPresenter()
        let router                = CreateRecordRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
  
    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivityIndicator()
        textArea.becomeFirstResponder()
    }
  
    func displayData(viewModel: CreateRecord.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .success:
            hideActivityIndicator()
            performSegue(withIdentifier: "RecordsList", sender: nil)
        case .displayFailure(let error):
            hideActivityIndicator()
            errorAlert(with: error)
        case .displayLoader:
            showActivityIndicator()
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func createRecordBarButtonItemPressed(_ sender: UIBarButtonItem) {
        //showActivityIndicator()
        let userText = textArea.text!
        interactor?.makeRequest(request: .passUserText(userText: userText))
    }
    
    @IBAction func cancelBarButtonItemPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // MARK: - UI
    
    func errorAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)

        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    func createActivityIndicator() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        loadingView.isHidden.toggle()
        view.addSubview(loadingView)
    }
    
    func showActivityIndicator() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        navigationController!.view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        navigationController!.view.isUserInteractionEnabled = true
    }
}
