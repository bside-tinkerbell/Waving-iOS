//
//  ServiceError.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation
import Moya

// 에러 내용
enum ServiceError: Error {
    case moyaError(MoyaError)
    case invalidResponse(responseCode: Int, message: String)
    case tokenExpired
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .moyaError(let moyaError):
            return moyaError.localizedDescription
        case let .invalidResponse(_, message):
            return message
        case .tokenExpired:
            return "AccessToken Expired"
        }
    }
}
