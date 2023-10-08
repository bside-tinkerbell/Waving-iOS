//
//  GreetingCategoryCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/23.
//

import Foundation

enum GreetingCategory: CaseIterable {
    case type1
    case type2
    case type3
    case type4
    case type5
    case type6
    
    var title: String {
        switch self {
        case .type1:
            return "잘지내?"
        case .type2:
            return "있어보이는 말"
        case .type3:
            return "응원의 마음"
        case .type4:
            return "고마워요"
        case .type5:
            return "축하해"
        case .type6:
            return "작은 위로"
        }
    }
    
    var greetingCategoryId: Int {
        switch self {
        case .type1:
            return 5
        case .type2:
            return 2
        case .type3:
            return 3
        case .type4:
            return 1
        case .type5:
            return 6
        case .type6:
            return 4
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
