//
//  DefaultAPICall.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

struct DefaultAPICall {
    private let requestPerformer: NetworkRequestPerformer
    
    init(_ requestPerformer: NetworkRequestPerformer) {
        self.requestPerformer = requestPerformer
    }
    
    func perform(_ request: NetworkRequest, _ completion: ((NetworkRequestResult) -> Void)?) {
        requestPerformer.perform(request, completion: completion)
    }
}
