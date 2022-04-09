//
//  AccountsResult.swift
//  DomRF
//
//  Created by Юрий Воскресенский on 04.12.2019.
//  Copyright © 2019 dom.rf. All rights reserved.
//

import Foundation

struct AccountsResult: Codable {

    let version: String
    let newsSites: [String]
}
