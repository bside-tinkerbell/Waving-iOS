//
//  FriendsContactCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/12.
//

import UIKit
import SnapKit

enum CellState {
    case checkBoxSelected
    case checkBoxUnselected
    case starSelected
    case starUnselected
}

class FriendsContactCollectionViewCell: UICollectionViewCell, SnapKitInterface {
    
    static let identifier = "FriendsContactCollectionViewCell"
    
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGreen
        return stackView
    }()
    
    private let profileImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "img_profile_small")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textstackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "이름 텍스트 전체 노출"
        label.font = .p_R(16)
        label.textAlignment = .left
        label.textColor = .text090
        return label
    }()
    
    private let numberLabel: UILabel = {
       let label = UILabel()
        label.text = "010-8699-7777"
        label.font = .p_R(12)
        label.textAlignment = .left
        label.textColor = .text030
        return label
    }()
    
//    let checkButtonView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBlue
//        return view
//    }()
    
    let checkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemYellow
        //button.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        [containerView, textstackView].forEach{ contentView.addSubview($0) }
        [profileImage, textstackView, checkButton].forEach { containerView.addArrangedSubview($0) }
        [nameLabel, numberLabel].forEach{ textstackView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-32)
            $0.centerY.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //TODO: 버튼 영역 넓혀서 클릭 잘되도록 하기 - UI 버튼 안에 이미지 작게 들어가도록 하기
        checkButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        containerView.setCustomSpacing(16, after: profileImage)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI(_ type: CellState) {
        switch type {
        case .checkBoxUnselected:
            numberLabel.isHidden = false
            checkButton.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        case .checkBoxSelected:
            numberLabel.isHidden = false
            checkButton.setImage(UIImage(named: "icn_checked"), for: .normal)
        case .starUnselected:
            numberLabel.isHidden = true
            checkButton.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
        case .starSelected:
            numberLabel.isHidden = true
            checkButton.setImage(UIImage(named: "icn_favorites_on"), for: .normal)
        }
    }
}
