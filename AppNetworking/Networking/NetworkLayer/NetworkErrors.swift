//
//  NetworkErrors.swift
//  AppNetworking
//
//  Created by Tatiana Sosina on 09.04.2022.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case invalidURLRequest
    case unacceptedHTTPStatusCode
    case unexpectedServerResponse
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unacceptedHTTPStatusCode:
            return Appearance().serverNotResponding
        case .noInternetConnection:
            return Appearance().noInternetConnection
        case .unexpectedServerResponse:
            return Appearance().unexpectedServerResponse
        case .invalidURLRequest:
            return Appearance().invalidURLRequest
        }
    }
}

extension NetworkError {
    struct Appearance {
        var serverNotResponding: String { "server_not_responding" }
        var noInternetConnection: String { "no_internet_connection" }
        var unexpectedServerResponse: String { "unexpected_response" }
        var invalidURLRequest: String { "invalid_url_request" }
    }
}
