//
//  APIEndpoint.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/10.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: String, Error {
    case invalidResponse
    case invalidData
    case clientError = "클라이언트 에러"//400대 에러
    case serverError = "서버 에러"// 500대 에러
}

