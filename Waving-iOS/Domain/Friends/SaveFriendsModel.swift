//
//  SaveFriendsModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/24.
//

import Foundation

struct SaveFriendsModel: Codable {
    var code: Int
    var result: SaveFriendsListModel
}

struct SaveFriendsListModel: Codable {
    var message: String
    var profileList: [ProfileListModel]
    
    enum CodingKeys: String, CodingKey {
        case message
        case profileList = "profile_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.profileList = try container.decode([ProfileListModel].self, forKey: .profileList)
    }
}

struct ProfileListModel: Codable {
    var contactId: Int
    var friendProfileId: Int
    var isFavorite: Int
    var name: String
    var birthday: String
    var contactCycle: Int
    var phoneNumber: String
    var recentContactDate: String
    
    enum CodingKeys: String, CodingKey {
        case contactId = "contact_id"
        case friendProfileId = "friend_profile_id"
        case isFavorite = "is_favorite"
        case name
        case birthday
        case contactCycle = "contact_cycle"
        case phoneNumber = "phone_number"
        case recentContactDate = "recent_contact_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contactId = try container.decode(Int.self, forKey: .contactId)
        self.friendProfileId = try container.decode(Int.self, forKey: .friendProfileId)
        self.isFavorite = try container.decode(Int.self, forKey: .isFavorite)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = (try? container.decode(String.self, forKey: .birthday)) ?? ""
        self.contactCycle = (try? container.decode(Int.self, forKey: .contactCycle)) ?? 0
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.recentContactDate = (try? container.decode(String.self, forKey: .recentContactDate)) ?? ""
    }
}

