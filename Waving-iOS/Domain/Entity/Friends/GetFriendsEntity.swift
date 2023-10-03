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
    
    public init(name: String, contactId: Int) {
        self.name = name
        self.contactId = contactId
    }
}
