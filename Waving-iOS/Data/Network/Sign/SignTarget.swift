//
//  SignTarget.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation
import Moya


//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

//ex) 만일 'ABC/DEF'에 token을 post로 보내야 한다고 가정
// case signIn(path: String, token: String)
enum SignTarget {
    case signIn
}

extension SignTarget: BaseTargetType {
    
    // root URL 뒤에 추가 될 Path
    // case .signIn(path, _) return "/\(path)"
    var path: String {
        switch self {
        case .signIn: return "/api/users"
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    var method: Moya.Method {
        switch self {
        case .signIn: return .get
        }
    }

    // task : request에 사용되는 파라미터 설정
    // - plain request : 추가 데이터가 없는 request
    // - data request : 데이터가 포함된 requests body
    // - parameter request : 인코딩된 매개 변수가 있는 requests body
    // - JSONEncodable request : 인코딩 가능한 유형의 requests body
    // - upload request
    var task: Task {
        switch self {
        case .signIn: return .requestPlain
        }
    }

}
