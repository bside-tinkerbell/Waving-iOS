//
//  GetFriendsProfileEntity.swift
//  Waving-iOS
//
//  Created by Joy on 12/22/23.
//

import Foundation

struct GetFriendsProfileEntity {
    static var shared = GetFriendsProfileEntity()
    
    var name: String? {
        didSet {
            Log.d("name: \(name!)")
        }
    }
    
    var contactId: Int? {
        didSet {
            Log.d("contactId: \(contactId!)")
        }
    }
    
    var friendProfileId: Int? {
        didSet{
            Log.d("friendProfileId: \(friendProfileId!)")
        }
    }

    var cellPhone: String? {
        didSet{
            Log.d("cellPhone: \(cellPhone!)")
        }
    }
}
