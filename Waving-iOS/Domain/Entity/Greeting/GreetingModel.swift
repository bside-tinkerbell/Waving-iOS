//
//  GreetingModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/14.
//

import Foundation

struct SampleGreetingModel: Codable {
    var message: String
}

struct GreetingModel: Codable {
    var code: Int
    var result: GreetingWrapperModel
}

struct GreetingWrapperModel: Codable {
    var greeting: String
    
    enum CodingKeys: String, CodingKey {
        case greeting
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.greeting = try container.decode(String.self, forKey: .greeting)
    }
}

struct GreetingCategoriesModel: Codable {
    var code: Int
    var result: GreetingCategoryList
}

struct GreetingCategoryList: Codable {
    var greetingCategoryList: [GreetingCategoryModel]
    
    enum CodingKeys: String, CodingKey {
        case greetingCategoryList = "greeting_category_list"
    }
}

struct GreetingCategoryModel: Codable {
    var greetingCategoryId: Int
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case greetingCategoryId = "greeting_category_id"
        case category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.greetingCategoryId = try container.decode(Int.self, forKey: .greetingCategoryId)
        self.category = try container.decode(String.self, forKey: .category)
    }
}
