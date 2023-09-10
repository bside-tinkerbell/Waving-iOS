//
//  SignRequestModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/09/10.
//

import Foundation

struct SignRequestModel: Codable {
    // sample sign request model
//    {
//        "gatherAgree": 1
//        , "username": "test2@test.com"
//        , "password": "11111111"
//        , "loginType": 1
//        , "name": "바나나"
//        , "birthday": "2000-01-02"
//        , "cellphone": "010-1111-2222"
//    }
    
    let gatherAgree: Int
    let email: String
    let password: String
    let loginType: Int
    let name: String
    let birthday: String
    let cellphone: String
}
