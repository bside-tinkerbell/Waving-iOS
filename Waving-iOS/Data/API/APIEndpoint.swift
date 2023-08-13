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

enum APIError: Error {
    case invalidResponse
    case invalidData
}

enum UserEndpoint: APIEndpoint {
    case getUsers
    
    var baseURL: URL {
        return URL(string: Server.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getUsers:
           return ["Content-type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getUsers:
            return nil
        }
    }
}
