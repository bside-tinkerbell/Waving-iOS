//
//  SignDataStore.swift
//  Waving-iOS
//
//  Created by USER on 2023/06/08.
//

import Foundation

struct LoginDataStore {
    static var shared = LoginDataStore()
    
    var userId: Int?
    var accessToken: String?
    var refreshToken: String?
}
struct SignDataStore {
    static var shared = SignDataStore()
    
    var phoneNumber: String? {
        didSet {
            guard let phoneNumber else { return }
            Log.d("phoneNumber: \(phoneNumber)")
            formattedPhoneNumber = PhoneNumberFormatter.format(text: phoneNumber)
        }
    }
    
    var formattedPhoneNumber: String? {
        didSet {
            Log.d("formattedPhoneNumber: \(formattedPhoneNumber!)")
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
            guard let birthdate else { return }
            Log.d("birthdate: \(birthdate)")
            formattedBirthdate = BirthdateFormatter.format(text: birthdate)
        }
    }
    
    var formattedBirthdate: String? {
        didSet {
            Log.d("formattedBirthdate: \(formattedBirthdate!)")
        }
    }
}

struct BirthdateFormatter {
    
    static let maxLength: Int = 8   // hyphen 미포함 (예. 19990101)
    static let hyphen = "-"
    
    static func format(text: String) -> String {
        guard text.count >= 8 else { return text }
        
        let result = String(text.prefix(maxLength))
        
        Log.d("text length: \(result.count). result: \(text)")
        let mutableString = NSMutableString(string: result)
        mutableString.replaceOccurrences(of: hyphen, with: "", range: .init(location: 0, length: text.count))
        mutableString.insert(hyphen, at: 4)
        mutableString.insert(hyphen, at: 7)
        return String(mutableString)
    }
}
