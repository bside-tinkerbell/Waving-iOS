//
//  SignAPI.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation

struct SignAPI: Networkable {
    typealias Target = SignTarget
    
    /// 테스트 함수(모야 작동 확인용)
    /// - Parameter request: TestModel
    /// - Returns: TestModel, Fail: Error
    static func getDataList(completion: @escaping(_ succeed: TestModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.sample) { result in
            switch ResponseData<TestModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
    
    /// 가입 인증코드 요청
    /// - Parameters:
    ///   - cellphone: 인증코드를 받을 휴대폰 번호
    static func requestAuthCode(cellphone: String, completion: @escaping (_ succeed: ResponseModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.requestSMS(cellphone)) { result in
            switch ResponseData<ResponseModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
    
    /// 가입 인증코드 확인
    /// - Parameters:
    ///   - cellphone: 가입할 휴대폰 번호
    ///   - authCode: 인증코드
    static func confirmAuthCode(cellphone: String, authCode: Int, completion: @escaping (_ succeed: ResponseModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.confirmAuthCode(cellphone, authCode)) { result in
            switch ResponseData<ResponseModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
    
    /// 가입 요청
    /// - Parameters:
    ///   - model: 가입 파라미터를 담은 모델
    static func signup(model: SignRequestModel, completion: @escaping (_ succeed: ResponseModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.signup(model)) { result in
            switch ResponseData<ResponseModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
    
    /// 로그인 요청
    /// - Parameters:
    ///   - model: 로그인 파라미터를 담은 모델
    static func login(model: LoginRequestModel, completion: @escaping (_ succeed: LoginResponseModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.login(model)) { result in
            switch ResponseData<LoginResponseModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }

}


