//
//  SignUpResponseModel.swift
//  Waving-iOS
//
//  Created by USER on 2023/09/26.
//

import Foundation

struct SignUpResponseModel: Codable {
    let code: Int
    let result: UserJoinResultWrapper
}

struct UserJoinResultWrapper: Codable {
    let userJoinResult: UserJoinResult
    
    enum CodingKeys: String, CodingKey {
        case userJoinResult = "user_join_result"
    }
}

struct UserJoinResult: Codable {
    let id: Int
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

/*
{
    "code": 200,
    "result": {
        "user_join_result": {
            "id": 12,
            "message": "success",
            "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MjJAdGVzdC5jb20iLCJpYXQiOjE2OTU3MzA1OTgsImV4cCI6MTY5NTgxNjk5OH0.ny7MeRMurhVATu56M1a86HNlLz38vX_dlzMdue16nMM",
            "refresh_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MjJAdGVzdC5jb20iLCJpYXQiOjE2OTU3MzA1OTgsImV4cCI6MTY5NjMzNTM5OH0.DmGwv2DwuFL8rPVWyPDCSsPxk14NADojJ7I9fNUNy-c"
        }
    }
}
*/
