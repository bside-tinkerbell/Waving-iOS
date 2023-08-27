//
//  GetFriendsEntity.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/17.
//

import Foundation

struct GetFriendsEntity {
    let name: String
    let friendProfileId: Int
    
    public init(name: String, friendProfileId: Int) {
        self.name = name
        self.friendProfileId = friendProfileId
    }
}
