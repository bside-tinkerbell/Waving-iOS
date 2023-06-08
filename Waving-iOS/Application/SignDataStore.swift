//
//  SignDataStore.swift
//  Waving-iOS
//
//  Created by USER on 2023/06/08.
//

import Foundation

struct SignDataStore {
    static var shared = SignDataStore()
    
    var phoneNumber: String?
    var email: String?
}
