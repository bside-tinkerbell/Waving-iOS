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

class FriendsContactCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FriendsContactCollectionViewCell"
    
    var contact: ContactModel {
        didSet {
            nameLabel.text = contact.name
            numberLabel.text = contact.phoneNumber
        }
    }
    
    /// 전체 컨테이너
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// 이미지
    private lazy var profileContainerView: UIView = {
       let imageContainerView = UIView()
        let imageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "img_profile_small")
            return image
        }()
        
        imageContainerView.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50)
        }
        return imageContainerView
    }()

    /// 텍스트
    private lazy var textStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    private var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "이름 텍스트 전체 노출"
        label.numberOfLines = 0
        label.font = .p_R(16)
        label.textAlignment = .left
        label.textColor = .text090
        return label
    }()
    
    private var numberLabel: UILabel = {
       let label = UILabel()
        label.text = "010-8699-7777"
        label.font = .p_R(12)
        label.textAlignment = .left
        label.textColor = .text030
        return label
    }()

    //TODO: 버튼 - 클릭 잘 되도록 조정하기
    private let buttonContainerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let checkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemYellow
        //button.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        return button
    }()

    
    override init(frame: CGRect) {
        self.contact = ContactModel(name: "", phoneNumber: "")
        
        super.init(frame: frame)
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        [nameLabel, numberLabel].forEach { textStackView.addArrangedSubview($0) }
        [profileContainerView, textStackView].forEach { containerStackView.addArrangedSubview($0) }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(_ type: CellState) {
        switch type {
        case .checkBoxUnselected:
            numberLabel.isHidden = false
            //checkButton.setImage(UIImage(named: "icn_unchecked"), for: .normal)
        case .checkBoxSelected:
            numberLabel.isHidden = false
            //checkButton.setImage(UIImage(named: "icn_checked"), for: .normal)
        case .starUnselected:
           numberLabel.isHidden = true
            //checkButton.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
        case .starSelected:
            numberLabel.isHidden = true
            //checkButton.setImage(UIImage(named: "icn_favorites_on"), for: .normal)
        case .none:
            numberLabel.isHidden = false
            //checkButton.setImage(UIImage(named: "icn_favorites_on"), for: .normal)
        }
    }
}
