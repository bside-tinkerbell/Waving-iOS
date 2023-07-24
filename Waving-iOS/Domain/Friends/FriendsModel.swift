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
    var name: String
    var phoneNumber: String
    var contactCycle: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case contactCycle = "contact_cycle"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.contactCycle = try container.decode(Int.self, forKey: .contactCycle)
    }
}


