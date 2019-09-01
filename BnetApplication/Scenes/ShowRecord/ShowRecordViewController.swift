//
//  ShowRecordViewController.swift
//  BnetApplication
//
//  Created by Артем Григорян on 01/09/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordDisplayLogic: class {
    func displayData(viewModel: ShowRecord.Model.ViewModel.ViewModelData)
}

class ShowRecordViewController: UIViewController, ShowRecordDisplayLogic {

    // MARK: - Public variables
    
    var interactor: ShowRecordBusinessLogic?
    var router: (NSObjectProtocol & ShowRecordRoutingLogic & ShowRecordDataPassing)?
    
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
        let interactor            = ShowRecordInteractor()
        let presenter             = ShowRecordPresenter()
        let router                = ShowRecordRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }

    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        textArea.delegate = self
        interactor?.makeRequest(request: .getRecord)
    }
    
    func displayData(viewModel: ShowRecord.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayRecord(let recordBody):
            textArea.text = recordBody
        }
    }
}

extension ShowRecordViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
