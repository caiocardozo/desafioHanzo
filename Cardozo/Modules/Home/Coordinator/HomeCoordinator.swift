//
//  HomeCoordinator.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 09/03/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import RxSwift

class HomeCoordinator: ReactiveCoordinator<Void> {
    let rootViewController: UIViewController
        
        init(rootViewController: UIViewController) {
            self.rootViewController = rootViewController
        }
        
        override func start() -> Observable<Void> {
            
            let viewController = rootViewController as! HomeViewController
            let viewModel = HomeViewModel()
            viewController.viewModel = viewModel
            
            viewModel.clickRepositorieButton
                .subscribe({ [weak self] _ in
                        self?.coordinatePublicRepositories()
                    })
                .disposed(by: disposeBag)
            
            return Observable.never()
        }
        
        // MARK: - Coordination
        private func coordinatePublicRepositories() {
            let holidayDetailCoordinator = PublicRepositoriesCoordinator(rootViewController: rootViewController)
            coordinate(to: holidayDetailCoordinator)
        }
}
