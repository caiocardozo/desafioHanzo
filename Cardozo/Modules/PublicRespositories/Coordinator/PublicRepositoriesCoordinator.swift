//
//  PublicRepositoriesCoordinator.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 09/03/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import RxSwift

class PublicRepositoriesCoordinator: ReactiveCoordinator<Void> {
let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    var viewModel: PublicRepositoryViewModel!

    override func start() -> Observable<Void> {
         let viewController = PublicRepositoryViewController()
         let viewModel = PublicRepositoryViewModel()
         viewController.viewModel = viewModel
         
         rootViewController.navigationController?
             .pushViewController(viewController, animated: true)
         return Observable.empty()
     }
}

