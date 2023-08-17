//
//  FriendsDataUseCase.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation
import Combine

protocol FriendsDataUseCaseInterface {
    func saveFriends() -> AnyPublisher<SaveFriendsResponseDTO, Error>
    func fetchFriendsEntity() -> AnyPublisher<[GetFriendsEntity], Error>
}

final class FriendsDataUseCase: FriendsDataUseCaseInterface {
    private let repository = FriendsRepository(dataSouce: FriendsDataSource())
    
    func saveFriends() -> AnyPublisher<SaveFriendsResponseDTO, Error> {
        return repository.saveFriends()
    }
    
    func fetchFriendsEntity() -> AnyPublisher<[GetFriendsEntity], Error> {
        return repository.fetchGetFriendsEntity()
    }
}
