//
//  APIConstants.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 16/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import Foundation




enum ConstantsApi {
    #if Prod
    static let urlApi = "https://api.github.com/"
    #else
    static let urlApi = "https://api.github.com/"
    #endif
    static let urlPublicRepositories: String = "repositories"
        
}

