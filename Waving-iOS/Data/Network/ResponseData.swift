//
//  ResponseData.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation
import Moya

struct ResponseData<Model: Codable> {

    static func getModelResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}


