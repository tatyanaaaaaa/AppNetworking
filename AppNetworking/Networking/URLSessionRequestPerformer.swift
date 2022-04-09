//
//  URLSessionRequestPerformer.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

protocol NetworkRequestPerformer {
    
    func perform(_ request: NetworkRequest, completion: ((NetworkRequestResult) -> Void)?)
}

final class URLSessionRequestPerformer {
    
    private var session: URLSession {
        let urlSession = URLSession.shared
        let config = urlSession.configuration
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = Appearance().timeOutInterval
        config.timeoutIntervalForResource = Appearance().timeOutInterval
        return urlSession
    }
}

// MARK: - NetworkRequestPerformer

extension URLSessionRequestPerformer: NetworkRequestPerformer {
    func perform(_ request: NetworkRequest, completion: ((NetworkRequestResult) -> Void)?) {
        
        guard let urlRequest = URLRequest(request) else {
            completion?(NetworkRequestResult(data: nil, error: NetworkError.invalidURLRequest))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? .zero
            
            if let error = error {
                self.printRequest(request, data: data, error: error, statusCode: statusCode)
                completion?(NetworkRequestResult(data: data, error: error))
            } else {
                if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                    self.printRequest(request, data: data, error: nil, statusCode: statusCode)
                    completion?(NetworkRequestResult(data: data, error: nil))
                } else {
                    self.printRequest(request, data: data, error: NetworkError.unacceptedHTTPStatusCode, statusCode: statusCode)
                    completion?(NetworkRequestResult(data: data, error: NetworkError.unacceptedHTTPStatusCode))
                }
            }
        }
        task.resume()
    }
    
    private func printRequest(_ request: NetworkRequest, data: Data?, error: Error?, statusCode: Int) {
        print("--------------- START REQUEST ---------------------------\n")
        print("Request url: \(request.baseUrl)\(request.path)")
        print("Request method: \(request.httpMethod)")
        
        if !request.httpHeaders.isEmpty {
            print("Request httpHeaders: \(request.httpHeaders)")
        }
        
        if !request.queryParameters.isEmpty {
            print("Request queryParameters: \(request.queryParameters)")
        }
        
        print("Status code: \(statusCode)")
        print("")
        
        if let error = error {
            print("🔴 🔴 🔴 🔴 🔴 🔴 ")
            print("ERROR: \(error)")
            print("🔴 🔴 🔴 🔴 🔴 🔴 ")
            print("\n--------------- END REQUEST ---------------------------")
            return
        }
        
        if let data = data {
            print("🟢 🟢 🟢 🟢 🟢 🟢 ")
            print("\(String(describing: String(data: data, encoding: .utf8)))")
            print("🟢 🟢 🟢 🟢 🟢 🟢 ")
        }
        print("\n--------------- END REQUEST ---------------------------")
    }
}

// MARK: - Appearance

extension URLSessionRequestPerformer {
    struct Appearance {
        var timeOutInterval: Double { 90 }
    }
}
