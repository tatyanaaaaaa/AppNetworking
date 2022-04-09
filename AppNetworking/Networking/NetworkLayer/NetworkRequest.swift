//
//  NetworkRequest.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

enum NetworkRequestHTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

protocol NetworkRequest {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: NetworkRequestHTTPMethod { get }
    var httpHeaders: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var shouldAddDefaultHeaders: Bool { get }
    var logRequest: Bool { get }
}

extension NetworkRequest {
    var shouldAddDefaultHeaders: Bool {
        true
    }
    var logRequest: Bool {
        true
    }
    var httpHeaders: [String: String] {
        [:]
    }
    var queryParameters: [String: Any] {
        [:]
    }
}
