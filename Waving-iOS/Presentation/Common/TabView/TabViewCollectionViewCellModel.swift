//
//  TabViewCollectionViewCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

public final class TabViewCollectionViewCellModel {
    
    // MARK: - Properties

    let name: TabViewItemName
    
    private(set) var newCountText: String?
    private(set) var isNewCountTextHidden: Bool = true
    private(set) var isNewMarkHidden: Bool = true
    
    var isSelected: Bool = false
    var isEnabled: Bool = true
    
    // MARK: - Initializers
    
    public convenience init(with nameText: String, numberOfItems items: Int = 0, numberOfNews news: Int = 0, isNewMarkHidden: Bool = true) {
        
        let name = TabViewItemName(forNormalState: NSMutableAttributedString(string: nameText), forSelectionState: NSMutableAttributedString(string: nameText))
        
        self.init(with: name, numberOfItems: items, numberOfNews: news, isNewMarkHidden: isNewMarkHidden)
    }
    
    public init(with name: TabViewItemName, numberOfItems items: Int = 0, numberOfNews news: Int = 0, isNewMarkHidden: Bool = true) {

        let normalStateName = NSMutableAttributedString(string: "normal")
            .wv_setFont(.p_B(15))
            .wv_setTextColor(.green)
        let selectionStateName = NSMutableAttributedString(string: "selection")
            .wv_setFont(.p_B(15))
            .wv_setTextColor(.orange)
        
        self.name = TabViewItemName(forNormalState: normalStateName, forSelectionState: selectionStateName)
        
        self.newCountText = ((news > 0) ? ((news > 99) ? "99+" : "\(news)") : nil)
        self.isNewCountTextHidden = (self.newCountText == nil)
        
        self.isNewMarkHidden = isNewMarkHidden
    }
}

@objc
public final class TabViewCollectionViewCellModelWrapper: NSObject {
    var model: TabViewCollectionViewCellModel
    
    @objc
    public init(nameText: String) {
        self.model = TabViewCollectionViewCellModel(with: nameText)
    }
    
}
