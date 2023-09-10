//
//  ResponseModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/09/03.
//

import Foundation

struct ResponseModel: Codable {
    var code: Int
    var result: ResultModel
}

struct ResultModel: Codable {
    var message: String
}
