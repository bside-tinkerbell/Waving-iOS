//
//  SampleEndPoint.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation

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
