//
//  ContactModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/23.
//

import Foundation

var personList = [PersonModel]()

// TODO: 1-Depth로 병합해도 좋을 듯
struct SaveFriendsDTO: Codable {
    var userId: Int
    var contactId: Int // 지인 목록 API GET해 왔을 때 주어지는 값
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
    
    init(userId: Int, contactId: Int, profileList: [PersonModel]){
        self.userId = userId
        self.contactId = contactId
        self.profileList = profileList
    }
}


struct PersonModel: Codable {
    var name: String
    var cellPhone: String
    var contactCycle: Int


    enum CodingKeys: String, CodingKey {
        case name
        case cellPhone = "cellphone"
        case contactCycle = "contact_cycle"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.cellPhone = try container.decode(String.self, forKey: .cellPhone)
        self.contactCycle = try container.decode(Int.self, forKey: .contactCycle)
    }

    init(name: String, cellPhone: String, contactCycle: Int) {
        self.name = name
        self.cellPhone = cellPhone
        self.contactCycle = contactCycle
    }
}


