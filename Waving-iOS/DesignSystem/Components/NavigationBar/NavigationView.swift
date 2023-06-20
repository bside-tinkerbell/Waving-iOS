//
//  NavigationView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/19.
//

import UIKit
import SnapKit
import Then

// _ 를 사이에 두고 왼쪽, 오른쪽의 item 들에 관한 정보로 네이밍함
enum NaviType {
    case button_text
    case button_iconImage
    case button_iconText
    case none_icon
    case button_twoicon
}

class NavigationView: UIView {
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_back"), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .p_R(18)
    }
    
    let favoriteButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
        $0.isHidden = true
    }
    
    let rightButton = UIButton().then { //텍스트, 이미지
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [backButton, titleLabel, favoriteButton, rightButton].forEach { addSubview($0) }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.Navi.commonPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(rightButton.snp.left).offset(-Constants.Navi.itemSpacing)
        }
        
        rightButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(Constants.Navi.commonPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    convenience init(frame: CGRect, type: NaviType) {
        self.init(frame: frame)

        switch type {
        case .button_text:
            backButton.isHidden = false
            favoriteButton.isHidden = true
            rightButton.isHidden = false
        case .button_iconImage:
            backButton.isHidden = false
            favoriteButton.isHidden = true
            rightButton.isHidden = false
            rightButton.setImage(UIImage(named: "icn_plus"), for: .normal)
        case .button_iconText:
            backButton.isHidden = false
            favoriteButton.isHidden = true
            rightButton.isHidden = false
            rightButton.setTitle("전체선택", for: .normal) //전체선택, 건너뛰기
            rightButton.setTitleColor(.black, for: .normal)
            rightButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            rightButton.snp.remakeConstraints {
                $0.right.equalToSuperview().inset(Constants.Navi.commonPadding)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 50, height: 22))
            }
        case .none_icon:
            backButton.isHidden = true
            favoriteButton.isHidden = true
            rightButton.isHidden = false
            rightButton.setImage(UIImage(named: "icn_plus"), for: .normal)
        case .button_twoicon:
            backButton.isHidden = false
            favoriteButton.isHidden = false
            favoriteButton.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
            rightButton.isHidden = false
            rightButton.setImage(UIImage(named: "icn_edit"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
