//
//  SignDataStore.swift
//  Waving-iOS
//
//  Created by USER on 2023/06/08.
//

import Foundation

struct SignDataStore {
    static var shared = SignDataStore()
    
    var phoneNumber: String? {
        didSet {
            Log.d("phoneNumber: \(phoneNumber!)")
        }
    }
    
    var email: String? {
        didSet {
            Log.d("email: \(email!)")
        }
    }
    
    var password: String? {
        didSet {
            Log.d("password: \(password!)")
        }
    }
    
    var username: String? {
        didSet {
            Log.d("username: \(username!)")
        }
    }
    
    var birthdate: String? {
        didSet {
            Log.d("birthdate: \(birthdate!)")
        }
    }
}
