//
//  FriendsRepository.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation
import Combine

protocol FriendsRepositoryInterface {
    func fetchGetFriendsEntity() -> AnyPublisher<[GetFriendsEntity], Error>
    func saveFriends() -> AnyPublisher<SaveFriendsResponseDTO, Error>
}

final class FriendsRepository: FriendsRepositoryInterface {
    
    private let dataSouce: FriendsDataSourceInterface
    
    public init(dataSouce: FriendsDataSourceInterface) {
        self.dataSouce = dataSouce
    }
    
    func fetchGetFriendsEntity() -> AnyPublisher<[GetFriendsEntity], Error> {
        return dataSouce.fetch()
            .map { getFriendsDTO in
                var getFriendsEntities = [GetFriendsEntity]()
                for profileList in getFriendsDTO.result.profileList { getFriendsEntities.append(profileList.toDomain())
                }
                return getFriendsEntities
            }
            .eraseToAnyPublisher()
    }
    
    func saveFriends() -> AnyPublisher<SaveFriendsResponseDTO, Error> {
        return dataSouce.save()
    }
}
