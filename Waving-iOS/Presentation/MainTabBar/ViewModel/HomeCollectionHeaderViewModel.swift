//
//  HomeCollectionHeaderViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/23.
//

import Foundation

final class HomeCollectionHeaderViewModel {
    @Published var title: String
    
    init(title: String) {
        self.title = title
    }
}
