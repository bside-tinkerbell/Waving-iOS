//
//  GreetingTarget.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/13.
//

import Foundation
import Moya

//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

//ex) 만일 'ABC/DEF'에서 email을 get해야 한다고 가정
/// "ABC"는 이미 URLString  파일에 위치한다면
/// case signIn
enum GreetingTarget {
    case randomGreeting
    case greetings(Int)
    case greetingCategories
}

extension GreetingTarget: BaseTargetType {
    
    // base URL 뒤에 추가 될 Path
    /// case .signIn:  return "/def"
    var path: String {
        switch self {
        case .randomGreeting:
            return "/greetings/main"
        case .greetings(let categoryId):
            return "/greetings/main/\(categoryId)"
        case .greetingCategories:
            return "/greetings/main/greeting-categories"
        }
    }
    
    /// parameter encoding
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .randomGreeting, .greetings, .greetingCategories:
            return JSONEncoding.default
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    /// .get
    var method: Moya.Method {
        switch self {
        case .randomGreeting, .greetings, .greetingCategories:
            return .get
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
        case .randomGreeting, .greetings, .greetingCategories:
            return .requestPlain
        case .greetings(let param):
            return .requestJSONEncodable(param)
        }
    }

}
