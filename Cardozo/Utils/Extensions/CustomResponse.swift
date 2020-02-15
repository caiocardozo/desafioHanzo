//
//  CustomResponse.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 22/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension Response {
    func parse(success: @escaping (Response)->(), error: @escaping (Int, String)->()) {
        if (statusCode >= 200 && statusCode < 300) {
            // Pode ter bem mais checagens, da para customizar esse método inteiro
            var responseString = ""
            do {
                responseString = try self.mapString()
                print(responseString)
            } catch {
                
            }
            success(self)
        } else {
            // talvez seja interessante pegar o model que o back ta mandando no erro e fazer
            // um let data = ErrorResponse(data: response.data)
            // aqui, assim da para pegar a mensagem que o back enviar e tal
            if statusCode == 401 { //end session
                
                //UIApplication.displayLogin()
            } else if statusCode == 500 { //end session
                error(statusCode, "Erro desconhecido")
            } else {
                error(statusCode, description)
            }
        }
    }
}
