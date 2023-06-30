//
//  BaseTargetType.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Moya
import Foundation

protocol BaseTargetType: TargetType {
    
}

extension BaseTargetType {
    
    public var baseURL: URL {
        return URL(string: Server.baseURL)!
    }
    
    // HTTP header
    //  return ["Content-type": "application/json"]
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    // 테스트용 Mock Data
    public var sampleData: Data {
        return Data()
    }
    
}
