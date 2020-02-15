//
//  CustomDataDecoder.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 16/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import Foundation

extension Data {
    func decode<T: Decodable>(onSuccess: @escaping (T)->(), onError: @escaping (String)->()) {
        if let object = try? JSONDecoder().decode(T.self, from: self) {
            onSuccess(object)
        } else {
            onError("Erro ao realizar o decodable")
        }
    }
    
    func decode<T: Decodable>(_ type:T.Type)->T? {
        do{
            let object = try JSONDecoder().decode(T.self, from: self)
            return object
        }
        catch{
            print(error)
            return nil
        }
    }
}
