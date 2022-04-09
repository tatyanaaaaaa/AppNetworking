//
//  AccountsRequest.swift
//  DomRF
//
//  Created by Юрий Воскресенский on 04.12.2019.
//  Copyright © 2019 dom.rf. All rights reserved.
//

import Foundation

struct AccountsRequest: NetworkRequest {
    var baseUrl: String = "https://api.spaceflightnewsapi.net"
    let httpMethod: NetworkRequestHTTPMethod = .get
    let path: String = "/v3/info"
}
