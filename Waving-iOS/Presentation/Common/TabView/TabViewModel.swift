//
//  TabViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import Foundation

public struct TabViewModel {
    
    // MARK: - Properties
    
    var cellViewModels: [TabViewCollectionViewCellModel]

    // MARK: - Initializers

    public init(with cellViewModels: [TabViewCollectionViewCellModel]) {
        
        self.cellViewModels = cellViewModels
        
    }
    
}

@objc
public final class TabViewModelWrapper: NSObject {
    
    var cellViewModels: [TabViewCollectionViewCellModel]
    
    @objc
    public init(with cellViewModelWrappers: [TabViewCollectionViewCellModelWrapper]) {
        
        self.cellViewModels = cellViewModelWrappers.compactMap { $0.model }
        
    }
    
}
