//
//  PublicRespositoryViewModel.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PublicRepositoryViewModel {
    
    //MARK: - Variables
    let disposeBag = DisposeBag()
    let loading = PublishSubject<Bool>()
    let error = PublishSubject<String>()
    let repositories = BehaviorRelay<[PublicRepositoryCellType]>(value: [])
    
    
    //MARk: - Request
    func fetchRequest() {
        self.loading.onNext(true)
        PublicRepository.getPublicRepositories(success: { (response) in
            self.loading.onNext(false)
            self.repositories.accept(response.map { PublicRepositoryCellType.withData(repository: $0) })
        }) { (error) in
            self.loading.onNext(false)
            self.error.onNext(error)
        }.disposed(by: self.disposeBag)
    }
}
