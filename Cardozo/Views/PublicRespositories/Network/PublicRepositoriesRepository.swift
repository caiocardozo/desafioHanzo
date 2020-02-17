//
//  PublicRepositorieRepository.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum PublicRepositoriesService {
    case getPublicRepositories
}


class PublicRepository: CustomRepository {

static let remoteDataSource = PublicRepositoryRemoteDataSource()

static func getPublicRepositories(success: @escaping ([PublicRepositoryModel])->(), error: @escaping (String)->()) -> Disposable {
    return remoteDataSource.getPublicRepositories().singleSubscribe(onSuccess: { (response: [PublicRepositoryModel]) in
        success(response)
    }, onError: { (message) in
        error(message)
    })
}

}

class PublicRepositoryRemoteDataSource {
    
    let provider = MoyaProvider<PublicRepositoriesService>()
    
    func getPublicRepositories() -> Single<Response>{
        return provider.rx.request(.getPublicRepositories)
    }
}

extension PublicRepositoriesService: TargetType {
    
    var baseURL: URL {
        return URL(string: ConstantsApi.urlApi)!
    }
    
    var path: String {
        switch self {
        case .getPublicRepositories:
            return ConstantsApi.urlPublicRepositories
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPublicRepositories:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getPublicRepositories:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
