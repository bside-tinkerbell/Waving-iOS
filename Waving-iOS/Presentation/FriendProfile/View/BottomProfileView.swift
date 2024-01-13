//
//  BottomProfileView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/07.
//

import UIKit

class BottomProfileView: UIView {
    
    private let memoryLabel: UILabel = {
       let label = UILabel()
        label.text = "추억 기록"
        label.textColor = .Text.text090
        label.font = .p_B(18)
        return label
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(memoryLabel)
        memoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
