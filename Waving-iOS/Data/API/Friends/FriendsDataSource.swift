//
//  FriendsDataSource.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation
import Combine

protocol FriendsDataSourceInterface {
    func save() -> AnyPublisher<SaveFriendsResponseDTO, Error>
    func fetch() -> AnyPublisher<GetFriendsDTO, Error>
}

final class FriendsDataSource: FriendsDataSourceInterface {
    let apiClient = URLSessionAPIClient<FriendsEndpoint>()
    
    func save() -> AnyPublisher<SaveFriendsResponseDTO, Error> {
        return apiClient.request(.saveFriends)
    }
    
    func fetch() -> AnyPublisher<GetFriendsDTO, Error> {
        return apiClient.request(.getFriends)
    }
}
