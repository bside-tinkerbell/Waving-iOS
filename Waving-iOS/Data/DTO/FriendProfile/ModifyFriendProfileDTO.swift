//
//  ModifyFriendProfileDTO.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/16.
//

import Foundation

struct ModifyFriendProfileDTO: Codable {
    var name: String
    var cellPhone: String
    var birthday: String
    var contactCycle: Int
    var recentContactDate: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case cellPhone
        case birthday
        case contactCycle = "contact_cycle"
        case recentContactDate = "recent_contact_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.cellPhone = try container.decode(String.self, forKey: .cellPhone)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.contactCycle = try container.decode(Int.self, forKey: .contactCycle)
        self.recentContactDate = try container.decode(String.self, forKey: .recentContactDate)
    }
}
