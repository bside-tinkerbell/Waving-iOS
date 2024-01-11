//
//  FriendsEndpoint.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation

enum FriendsEndpoint: APIEndpoint {
    case saveFriends
    case getFriends
    
    var baseURL: URL {
        return URL(string: Server.baseURL)!
    }
    
    var path: String {
        switch self {
        case .saveFriends:
            return "/v1/friends/register"
        case .getFriends:
            let userId = LoginDataStore.shared.userId ?? 0
           return "/v1/friends/list/" + "\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .saveFriends:
            return .post
        case .getFriends:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .saveFriends, .getFriends:
           return ["Content-type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .saveFriends:
             let saveFriendsDTO = SaveFriendsDTO(userId: LoginDataStore.shared.userId!, contactId: SaveContactEntity.shared.contactId, profileList: saveContactList)
            return saveFriendsDTO.asDictionary
        case .getFriends:
            return nil
        }
    }
}
