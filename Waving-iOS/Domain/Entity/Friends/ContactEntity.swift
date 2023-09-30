//
//  ContactModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/23.
//

import Foundation

var myContactList = [ContactEntity]()
var saveContactList = [ContactEntity]()

struct ContactEntity {
    let name: String
    let phoneNumber: String
    let contactCycle: Int = 2
}

struct SaveContactEntity {
    static var shared = SaveContactEntity()
    
    var contactId: Int = 0
}
