//
//  TopProfileView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/07.
//

import UIKit

final class TopProfileView: UIView, SnapKitInterface {

    var viewModel = FriendProfileViewModel()
    // MARK: - Components
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    private lazy var profileContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profileImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "img_profile_medium")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = GetFriendsProfileEntity.shared.name
        label.textColor = .text090
        label.font = .p_B(20)
        return label
    }()
    
    let contactButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.text090, for: .normal)
        button.setTitle("연락하기", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.text090.cgColor
        return button
    }()
    
    // 생일
    private var birthdayContainerView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let birthdayLabel: UILabel = {
       let label = UILabel()
        label.text = "생일"
        label.textColor = .text090
        label.font = .p_B(18)
        return label
    }()
    
    private let birthdayInputLabel: UILabel = { // TODO: picker바꾸기
       let label = UILabel()
        label.text = "생일을 입력해 주세요."
        label.textColor = .text030
        label.font = .p_R(18)
        return label
    }()
    
    
    // 연락주기
    private var cycleContainerView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let cycleLabel: UILabel = {
       let label = UILabel()
        label.text = "연락주기"
        label.textColor = .text090
        label.font = .p_B(18)
        return label
    }()
    
    private let cycleInputLabel: UILabel = { // TODO: picker바꾸기
       let label = UILabel()
        label.text = "반복주기 2주마다"
        label.textColor = .text030
        label.font = .p_R(18)
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addComponents() {
        addSubview(containerView)
        [profileContainerView, nameLabel, contactButton, birthdayContainerView, cycleContainerView].forEach { containerView.addArrangedSubview($0) }
        profileContainerView.addSubview(profileImage)
        //[birthdayLabel, birthdayInputLabel].forEach { birthdayContainerView.addArrangedSubview($0) }
        [cycleLabel, cycleInputLabel].forEach { cycleContainerView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-20)
        }

        profileContainerView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        profileImage.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(25)
        }

        contactButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    func binding() {
        contactButton.addTarget(self, action: #selector(didTapCall), for: .touchUpInside)
    }
    
    @objc
    func didTapCall(){
        viewModel.call()
    }
}
