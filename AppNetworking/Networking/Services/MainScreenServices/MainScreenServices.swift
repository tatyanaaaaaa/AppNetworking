//
//  MainScreenServices.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

protocol MainScreenServices {
    func getContent(_ completion: ((RemoteServiceResult<AccountsResult>) -> Void)?)
}

struct MainScreenServicesImpl {

    private let requestPerformer: NetworkRequestPerformer

    init(_ requestPerformer: NetworkRequestPerformer) {
        self.requestPerformer = requestPerformer
    }
}

extension MainScreenServicesImpl: MainScreenServices {
    func getContent(_ completion: ((RemoteServiceResult<AccountsResult>) -> Void)?) {
        let apiCall = DefaultAPICall(requestPerformer)
        apiCall.perform(AccountsRequest()) { result in
            let mappedResult: RemoteServiceResult<AccountsResult> = CodableResultMapper().map(result)
            completion?(mappedResult)
        }
    }
}
