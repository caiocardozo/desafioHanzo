//
//  CustomRepository.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 22/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift

class CustomRepository {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func errorBlock(subscribeError: Error, error: @escaping (String)->()) {
        if !isConnectedToInternet {
            error("status_tableview_not_connected_message".localized)
        } else {
            let errorMessage = "unknown_error".localized
            if let response1 = subscribeError as? MoyaError, let response = response1.response {
                if let statusCode = response.response?.statusCode {
                    if statusCode == 401 {
                        error("session_error".localized)
                    } else {
                        error(errorMessage)
                    }
                }
            }
            error(errorMessage)
        }
    }
    
}

extension PrimitiveSequenceType where Self.TraitType == RxSwift.SingleTrait{
    
    func singleSubscribe(onSuccess: @escaping () -> (), onError: @escaping (String) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    onSuccess()
                }, error: { (statusCode, message) in
                    onError(message)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (errorString) in
                onError(errorString)
            })
        })
    }
    
    func singleSubscribe<T: Decodable>(onSuccess: @escaping (T) -> (), onError: @escaping (String) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    successResponse.data.decode(onSuccess: { (Decodable) in
                        onSuccess(Decodable)
                    }, onError: { (Error) in
                        onError(Error)
                    })
                }, error: { (statusCode, message) in
                    onError(message)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (errorString) in
                onError(errorString)
            })
        })
    }
    
    func singleSubscribeWithCode<T: Decodable>(onSuccess: @escaping (T) -> (), onError: @escaping (String,Int) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    successResponse.data.decode(onSuccess: { (Decodable) in
                        onSuccess(Decodable)
                    }, onError: { (Error) in
                        onError(Error,0)
                    })
                }, error: { (statusCode, message) in
                    onError(message,statusCode)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (errorString) in
                onError(errorString,0)
            })
        })
    }
    
    func singleSubscribe<T: Decodable>(onSuccess: @escaping ([T]) -> (), onError: @escaping (String) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    successResponse.data.decode(onSuccess: { (Decodable) in
                        onSuccess(Decodable)
                    }, onError: { (Error) in
                        onError(Error)
                    })
                }, error: { (statusCode, message) in
                    onError(message)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (errorString) in
                onError(errorString)
            })
        })
    }
}

