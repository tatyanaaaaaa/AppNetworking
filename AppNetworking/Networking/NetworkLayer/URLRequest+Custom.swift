//
//  URLRequest+Custom.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

extension URLRequest {
    init?(_ networkRequest: NetworkRequest) {
        guard let url = URL(baseUrl: networkRequest.baseUrl,
                            path: networkRequest.path,
                            params: networkRequest.queryParameters,
                            method: networkRequest.httpMethod) else { return nil }
        self.init(url: url)
        
        httpMethod = networkRequest.httpMethod.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkRequest.httpHeaders.forEach {
            setValue($1, forHTTPHeaderField: $0)
        }
        
        switch networkRequest.httpMethod {
        case .post, .put, .head, .patch, .trace, .connect:
            if let jsonBody = try? JSONSerialization.data(withJSONObject: networkRequest.queryParameters) {
                httpBody = jsonBody
            }
        default:
            break
        }
    }
}

extension URL {
    init?(baseUrl: String, path: String, params: [String: Any], method: NetworkRequestHTTPMethod) {
        var components = URLComponents(string: baseUrl)
        
        components?.path += path
        components?.queryItems = params.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        guard let url = components?.url else { return nil }
        self = url
    }
}
