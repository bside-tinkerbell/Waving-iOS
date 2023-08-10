//
//  SampleAPI.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import Foundation

struct SampleAPI: Networkable {
    typealias Target = SampleTarget
    
    static func getSampleList(completion: @escaping(_ succeed: SampleResponseDTO?, _ failed: Error?) -> Void) {
        
        makeProvider().request(.sample) { result in
            switch ResponseData<SampleResponseDTO>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        }
    }
}
