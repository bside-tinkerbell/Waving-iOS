//
//  ContactModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/23.
//

import Foundation

struct FriendsModel: Codable {
    var contact_id: Int
    var user_id: Int
    var profile_list: [PersonModel]
    
    enum CodingKeys: String, CodingKey {
        case contact_id
        case user_id
        case profile_list
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contact_id = try container.decode(Int.self, forKey: .contact_id)
        self.user_id = try container.decode(Int.self, forKey: .user_id)
        self.profile_list = try container.decode([PersonModel].self, forKey: .profile_list)
    }
}


struct PersonModel: Codable {
    var contact_id: Int
    var friend_profile_id: Int
    var name: String
    var phone_number: String
    var birthday: String
    var is_favorite: Int
    
    enum CodingKeys: String, CodingKey {
        case contact_id
        case friend_profile_id
        case name
        case phone_number
        case birthday
        case is_favorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contact_id = try container.decode(Int.self, forKey: .contact_id)
        self.friend_profile_id = try container.decode(Int.self, forKey: .friend_profile_id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone_number = try container.decode(String.self, forKey: .phone_number)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.is_favorite = try container.decode(Int.self, forKey: .is_favorite)
    }
}


