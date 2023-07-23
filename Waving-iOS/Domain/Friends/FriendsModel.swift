//
//  ContactModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/23.
//

import Foundation

struct FriendsModel: Codable {
    var contactId: Int
    var userId: Int
    var profileList: [PersonModel]
    
    enum CodingKeys: String, CodingKey {
        case contactId = "contact_id"
        case userId = "user_id"
        case profileList = "profile_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contactId = try container.decode(Int.self, forKey: .contactId)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.profileList = try container.decode([PersonModel].self, forKey: .profileList)
    }
}


struct PersonModel: Codable {
    var contactId: Int
    var friendProfileId: Int
    var name: String
    var phoneNumber: String
    var birthday: String
    var isFavorite: Int
    
    enum CodingKeys: String, CodingKey {
        case contactId = "contact_id"
        case friendProfileId = "friend_profile_id"
        case name
        case phoneNumber = "phone_number"
        case birthday
        case isFavorite = "is_favorite"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contactId = try container.decode(Int.self, forKey: .contactId)
        self.friendProfileId = try container.decode(Int.self, forKey: .friendProfileId)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.isFavorite = try container.decode(Int.self, forKey: .isFavorite)
    }
}


