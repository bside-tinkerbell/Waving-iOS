//
//  APIClient.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/10.
//

import Foundation
import Combine
import UIKit

protocol APIClient { 
    associatedtype EndpointType: APIEndpoint
    func request<T: Codable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }

        return httpBody
    }
    
    func request<T: Codable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = requestBodyFrom(params: endpoint.parameters)
        
        // 데이터 통신
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
