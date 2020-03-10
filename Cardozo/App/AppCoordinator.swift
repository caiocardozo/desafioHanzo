//
//  AppCoordinator.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 09/03/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import RxSwift

class AppCoordinator: ReactiveCoordinator<Void> {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        
        let holidaysCoordinator = HomeCoordinator(rootViewController: navigationController.viewControllers[0])
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: holidaysCoordinator)
    }
}
