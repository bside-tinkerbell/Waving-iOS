//
//  GreetingCategoryCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/23.
//

import Foundation

enum GreetingCategory {
    case type1
    case type2
    case type3
    case type4
    case type5
    case type6
    
    fileprivate var title: String {
        switch self {
        case .type1:
            return "궁금해요"
        case .type2:
            return "명언 한줄"
        case .type3:
            return "응원해요"
        case .type4:
            return "고마워요"
        case .type5:
            return "축하해요"
        case .type6:
            return "위로해요"
        }
    }
}

final class GreetingCategoryCellModel {
    @Published var category: GreetingCategory
    @Published var title: String
    
    init(category: GreetingCategory) {
        self.category = category
        self.title = category.title
    }
}
