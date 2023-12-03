//
//  SignTarget.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation
import Moya


//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

//ex) 만일 'ABC/DEF'에서 email을 get해야 한다고 가정
/// "ABC"는 이미 URLString  파일에 위치한다면
/// case signIn
enum SignTarget {
    case signIn
    case sample
    case requestSMS(String)
    case confirmAuthCode(String, Int)
    case signup(SignRequestModel)
    case login(LoginRequestModel)
    case logout
    case delete(userId: Int)
}

extension SignTarget: BaseTargetType, AccessTokenAuthorizable {
    
    // base URL 뒤에 추가 될 Path
    /// case .signIn:  return "/def"
    var path: String {
        switch self {
        case .signIn: 
            return ""
        case .sample: 
            return "/api/users"
        case .requestSMS: 
            return "/v1/users/authentication"
        case .confirmAuthCode: 
            return "/v1/users/authentication-confirm"
        case .signup: 
            return "/v1/users/join"
        case .login: 
            return "/v1/auth/login"
        case .logout: 
            return "/v1/auth/logout"
        case .delete(let userId): 
            return "/v1/users/\(userId)"
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    /// .get
    var method: Moya.Method {
        switch self {
        case .signIn, .sample:
            return .get
        case .requestSMS, .confirmAuthCode, .signup, .login:
            return .post
        case .logout:
            return .patch
        case .delete:
            return .delete
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
        case .signIn, .sample, .logout, .delete:
            return .requestPlain
        case .requestSMS(let cellphone):
            return .requestParameters(parameters: ["cellphone": cellphone], encoding: JSONEncoding.default)
        case .confirmAuthCode(let cellphone, let authCode):
            return .requestParameters(parameters: ["cellphone": cellphone, "code": authCode], encoding: JSONEncoding.default)
        case .signup(let model):
            let params: [String: Any] = ["gatherAgree": model.gatherAgree,
                                         "username": model.email,
                                         "password": model.password,
                                         "loginType": model.loginType,
                                         "name": model.name,
                                         "birthday": model.birthday,
                                         "cellphone": model.cellphone]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .login(let model):
            let params: [String: Any] = ["username": model.email,
                                         "password": model.password]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        case .signup, .signIn:
            return .none
        default:
            return .bearer
        }
    }
}
