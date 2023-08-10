//
//  SampleTarget.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import Foundation
import Moya

enum SampleTarget {
    case sample
}

extension SampleTarget: BaseTargetType {
    
    // base URL 뒤에 추가 될 Path
    /// case .signIn:  return "/def"
    var path: String {
        switch self {
        case .sample: return "/api/users"
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    /// .get
    var method: Moya.Method {
        switch self {
        case .sample: return .get
        }
    }

    // task : request에 사용되는 파라미터 설정
    /// - plain request : 추가 데이터가 없는 request
    /// - data request : 데이터가 포함된 requests body
    /// - parameter request: 인코딩된 매개 변수가 있는 requests body
    /// - JSONEncodable request : 인코딩 가능한 유형의 requests body
    /// - upload request

    /// .plain request
    var task: Task {
        switch self {
        case .sample: return .requestPlain
        }
    }

}

