//
//  ContactModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/23.
//

import Foundation

var myContactList = [ContactEntity]()
var saveContactList = [ContactEntity]()


struct ContactEntity: Codable {
    let name: String
    let cellPhone: String
    var contactCycle: Int = 2
    
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

struct SaveContactEntity {
    static var shared = SaveContactEntity()
    
    var contactId: Int = 0
}
