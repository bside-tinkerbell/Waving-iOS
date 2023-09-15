//
//  LoginResponseModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/09/15.
//

import Foundation

struct LoginResponseModel: Codable {
    let code: Int
    let result: TokenModel
}

struct TokenModel: Codable {
    let id: Int
    let accessToken: String
    let refreshToken: String
}

/*
 {
     "code": 200,
     "result": {
         "token": {
             "id": 4,
             "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDaG9pYXByaWw2QGdtYWlsLmNvbSIsImlhdCI6MTY5NDc0NDIwNiwiZXhwIjoxNjk0ODMwNjA2fQ.OEsQJG4mHJiI9pEf6eUkWF6sI_PuVXWiLatjh6AOQy4",
             "refresh_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDaG9pYXByaWw2QGdtYWlsLmNvbSIsImlhdCI6MTY5NDc0NDIwNiwiZXhwIjoxNjk1MzQ5MDA2fQ.TaVAW6K9XuLOiA5t37dOfGKVExJkiVOm7A3UKXlSIws"
         }
     }
 }
 */
