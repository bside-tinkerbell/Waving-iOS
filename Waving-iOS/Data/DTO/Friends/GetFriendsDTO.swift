//
//  GetFriendsDTO.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/16.
//

import Foundation

struct GetFriendsDTO: Codable {
    var code: Int
    var result: GetFriendsResultDTO
}

struct GetFriendsResultDTO: Codable {
    var message: String
    var profileList: [GetFriendsProfileDTO]
    var favoriteProfileList: [GetFriendsProfileDTO]
    var profileCount: Int
    var favoriteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case message
        case profileList = "profile_list"
        case favoriteProfileList = "favorite_profile_list"
        case profileCount = "profile_cnt"
        case favoriteCount = "favorite_cnt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.profileList = try container.decode([GetFriendsProfileDTO].self, forKey: .profileList)
        self.favoriteProfileList = try container.decode([GetFriendsProfileDTO].self, forKey: .favoriteProfileList)
        self.profileCount = try container.decode(Int.self, forKey: .profileCount)
        self.favoriteCount = try container.decode(Int.self, forKey: .favoriteCount)
    }
}

struct GetFriendsProfileDTO: Codable {
    var contactId: Int
    var friendProfileId: Int
    var isFavorite: Int
    var name: String
    var birthday: String
    var contactCycle: Int
    var cellPhone: String
    var recentContactDate: String
    
    enum CodingKeys: String, CodingKey {
        case contactId = "contact_id"
        case friendProfileId = "friend_profile_id"
        case isFavorite = "is_favorite"
        case name
        case birthday
        case contactCycle = "contact_cycle"
        case cellPhone = "cellphone"
        case recentContactDate = "recent_contact_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contactId = try container.decode(Int.self, forKey: .contactId)
        self.friendProfileId = try container.decode(Int.self, forKey: .friendProfileId)
        self.isFavorite = try container.decode(Int.self, forKey: .isFavorite)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = (try? container.decode(String.self, forKey: .birthday)) ?? ""
        self.contactCycle = try container.decode(Int.self, forKey: .contactCycle)
        self.cellPhone = try container.decode(String.self, forKey: .cellPhone)
        self.recentContactDate = (try? container.decode(String.self, forKey: .recentContactDate)) ?? ""
    }
}

extension GetFriendsProfileDTO {
    func toDomain() -> GetFriendsEntity {
        return .init(name: name, friendProfileId: friendProfileId)
    }
}

