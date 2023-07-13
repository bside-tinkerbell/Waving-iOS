//
//  GreetingAPI.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/13.
//

import Foundation

struct GreetingAPI: Networkable {
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
}
