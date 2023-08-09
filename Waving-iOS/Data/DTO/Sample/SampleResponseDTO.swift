//
//  SampleResponseDTO.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import Foundation

struct SampleResponseDTO: Codable {
    let page: Int
    let data: [SampleDataDTO]
}

struct SampleDataDTO: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
    }
}

extension SampleDataDTO {
    func toDomain() -> SampleEntity {
        return .init(firstName: firstName, lastName: lastName)
    }
}
