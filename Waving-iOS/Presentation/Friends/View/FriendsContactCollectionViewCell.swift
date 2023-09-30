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
    case none
}

class FriendsContactCollectionViewCell: UICollectionViewCell, SnapKitInterface {

    static let identifier = "FriendsContactCollectionViewCell"
    
    // MARK: - Model (data)
    var contact: ContactEntity {
        didSet {
            nameLabel.text = contact.name
            numberLabel.text = contact.phoneNumber
        }
    }
    
    var friendsList: GetFriendsEntity {
        didSet {
            nameLabel.text = friendsList.name
        }
    }
    
    
    // MARK: - Components
    /// 전체 컨테이너
    private let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    /// 이미지
    private lazy var profileStackView: UIStackView = {
       let imageStackView = UIStackView()
        imageStackView.alignment = .center
  
        let imageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "img_profile_small")
            return image
        }()
        
        imageStackView.addArrangedSubview(imageView)

        return imageStackView
    }()

    /// 텍스트
    private lazy var textStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "이름 텍스트 전체 노출"
        label.numberOfLines = 0
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
    
    /// 버튼
    private lazy var buttonView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let selectButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        return button
    }()

    // MARK: - init
    override init(frame: CGRect) {
        self.contact = ContactEntity(name: "", phoneNumber: "")
        self.friendsList = GetFriendsEntity(name: "", friendProfileId: 0)
        super.init(frame: frame)
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        addSubview(containerView)
        [nameLabel, numberLabel].forEach { textStackView.addArrangedSubview($0) }
        buttonView.addSubview(selectButton)
        [profileStackView, textStackView, buttonView].forEach { containerView.addSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        profileStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        textStackView.snp.makeConstraints {
            $0.left.equalTo(profileStackView.snp.right).offset(16)
            $0.centerY.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints {
            $0.width.equalTo(66)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func configUI(_ type: CellState) {
        switch type {
        case .checkBoxUnselected:
            numberLabel.isHidden = false
            selectButton.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        case .checkBoxSelected:
            numberLabel.isHidden = false
            selectButton.setImage(UIImage(named: "icn_checked"), for: .normal)
        case .starUnselected:
           numberLabel.isHidden = true
            selectButton.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
        case .starSelected:
            numberLabel.isHidden = true
            selectButton.setImage(UIImage(named: "icn_favorites_on"), for: .normal)
        case .none:
            numberLabel.isHidden = true
            buttonView.isHidden = true
        }
    }
}
