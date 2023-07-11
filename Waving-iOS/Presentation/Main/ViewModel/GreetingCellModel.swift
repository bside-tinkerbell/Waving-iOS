//
//  GreetingCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/10.
//

import Foundation

final class GreetingCellModel {
    @Published var greeting: NSAttributedString
    var categoryId: Int
    var greetingId: Int
    
    init(title: String, categoryId: Int, greetingId: Int) {
        self.greeting = NSMutableAttributedString(string: title)
            .wv_setFont(.p_M(20))
            .wv_setTextColor(.gray090)
        self.categoryId = categoryId
        self.greetingId = greetingId
    }
}
