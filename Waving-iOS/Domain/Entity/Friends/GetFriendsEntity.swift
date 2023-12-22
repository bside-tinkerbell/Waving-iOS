//
//  GetFriendsEntity.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation

struct GetFriendsEntity {
    
    let name: String
    let contactId: Int
    let friendProfileId: Int
    let cellPhone: String
    
    public init(name: String, contactId: Int, friendProfileId: Int, cellPhone: String) {
        self.name = name
        self.contactId = contactId
        self.friendProfileId = friendProfileId
        self.cellPhone = cellPhone
    }
}
