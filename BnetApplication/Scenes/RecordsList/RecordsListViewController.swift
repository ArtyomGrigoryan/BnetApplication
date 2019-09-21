//
//  RecordsListViewController.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListDisplayLogic: class {
    func displayData(viewModel: RecordsList.Model.ViewModel.ViewModelData)
}

class RecordsListViewController: UITableViewController, RecordsListDisplayLogic {

    // MARK: - Public variables
    
    var interactor: RecordsListBusinessLogic?
    var router: (NSObjectProtocol & RecordsListRoutingLogic & RecordsListDataPassing)?
    
    // MARK: - Private variables
    
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    private var recordsViewModel = RecordsViewModel(cells: [])

    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = RecordsListInteractor()
        let presenter             = RecordsListPresenter()
        let router                = RecordsListRouter()
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
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
  
    func displayData(viewModel: RecordsList.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayRecords(let viewModel):
            hideActivityIndicator()
            recordsViewModel = viewModel
            tableView.reloadData()
        case .displayError(let error):
            hideActivityIndicator()
            errorAlert(with: error)
        case .displayLoader:
            showActivityIndicator()
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        interactor?.makeRequest(request: .getRecords)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsViewModel.cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordsListTableViewCell.self), for: indexPath) as! RecordsListTableViewCell
        let cellViewModel = recordsViewModel.cells[indexPath.row]
        
        cell.configureCell(viewModel: cellViewModel)
        
        return cell
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
        loadingView.center = navigationController!.view.center
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.isHidden = true

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        navigationController!.view.addSubview(loadingView)
    }
    
    func showActivityIndicator() {
        loadingView.isHidden.toggle()
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        loadingView.isHidden.toggle()
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}
