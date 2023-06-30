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
        makeProvider().request(.signIn) { result in
            switch ResponseData<TestModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
}
