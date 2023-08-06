//
//  NoticeCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/17.
//

import Foundation

enum NoticeType {
    case contact
    case memoryRecord
    case anniversary
    case announcement
}

final class NoticeCellModel {
    let type: NoticeType
    let title: String
    let description: String
    
    init(type: NoticeType, title: String, description: String) {
        self.type = type
        self.title = title
        self.description = description
    }
}
