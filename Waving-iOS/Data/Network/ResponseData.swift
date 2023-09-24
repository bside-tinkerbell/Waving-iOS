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
                if let keyNotFound = error as? DecodingError {
                    switch keyNotFound {
                    case .keyNotFound(let key, _):
                        print("Key '\(key.stringValue)' not found.")
                    default:
                        print("Decoding error: \(error.localizedDescription)")
                    }
                } else {
                    print("Decoding error: \(error.localizedDescription)")
                }
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}


