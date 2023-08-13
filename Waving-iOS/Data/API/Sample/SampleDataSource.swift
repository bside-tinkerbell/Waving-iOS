//
//  SampleDataSource.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/10.
//

import Foundation
import Combine

protocol SampleDataSourceInterface {
    func getUsers() -> AnyPublisher<SampleResponseDTO, Error>
}

class SampleDataSource: SampleDataSourceInterface {
    let apiClient = URLSessionAPIClient<UserEndpoint>()
    
    func getUsers() -> AnyPublisher<SampleResponseDTO, Error> {
        return apiClient.request(.getUsers)
    }
}
