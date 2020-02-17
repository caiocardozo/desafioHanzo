//
//  PublicRepositoryViewController.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import UIKit
import RxSwift

class PublicRepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PublicRepositoryViewModel()
    private let cellRepository = "PublicRepositoryTableViewCell"
    private let cellRepositoryEmpty = "PublicRepositoryEmptyTableViewCell"
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupObservables()
        setupTableView()
        loadData()
    }
    
    private func setup() {
        self.title = "Repositórios"
    }
    
    private func setupObservables() {
        self.viewModel.loading.asObservable().bind{(loading) in
            self.setLoader(show: loading)
        }.disposed(by: self.disposeBag)
        
        self.viewModel.error.asObservable().bind{(message) in
            self.showErrorAlert(message: message)
        }.disposed(by: self.disposeBag)
    }
    
    
    private func setupTableView() {
        self.tableView.registerNib(named: self.cellRepository)
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.registerNib(named: self.cellRepositoryEmpty)
        
        self.viewModel.repositories.asObservable().bind(to: self.tableView.rx.items) { tableView , index , element in
            switch element {
            case .withData(let repository):
                self.tableView.rowHeight  = UITableView.automaticDimension
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellRepository) as! PublicRepositoryTableViewCell
                cell.setup(repository: repository)
                return cell
            case .empty:
                tableView.rowHeight = self.tableView.frame.height
                let cellEmpty = tableView.dequeueReusableCell(withIdentifier: self.cellRepositoryEmpty) as! PublicRepositoryEmptyTableViewCell
                return cellEmpty
            }
        }.disposed(by: self.disposeBag)
    }
    
    //MARK: - Requests
    private func loadData() {
        self.viewModel.fetchRequest()
    }
}
