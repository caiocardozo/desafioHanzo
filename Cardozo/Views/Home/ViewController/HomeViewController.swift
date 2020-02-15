//
//  HomeViewController.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 15/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Outlets
    
    
    //MARK: - Constants
    let viewModel = HomeViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    private func setup() {
        self.title = "Codable"
    }

   

}
