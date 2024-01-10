//
//  FriendsDisconnectView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/21.
//


import UIKit
import Combine

class FriendsDisconnectView: UIView, SnapKitInterface {
    
    var viewModel: FriendsViewModelRepresentable?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let vingvingImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doordog")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let subLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center 
        label.attributedText = NSMutableAttributedString(string: "연락처를 가져올 수 없습니다.\n[설정] > [연락처 허용]을 해주세요.")
            .wv_setFont(.p_R(16))
            .wv_setTextColor(.Text.text050)
        return label
    }()
    
    let friendsAddButton = WVButton()
    private lazy var friendAddButtonViewModel = WVButtonModel(title: "지인 불러오기", titleColor: .Text.white, backgroundColor: .Button.mainBlackButton) { [weak self] in
        self?.viewModel?.addFriends()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addComponents() {
        addSubview(containerView)
        [subLabel, vingvingImage, friendsAddButton].forEach { containerView.addSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        

        vingvingImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(228)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(180)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(vingvingImage.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
        }

        friendsAddButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: Constants.Intro.loginButtonWidth, height: Constants.Intro.loginButtonHeight))
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        friendsAddButton.setup(model: friendAddButtonViewModel)
       // bringSubviewToFront(friendsAddButton)
    }
}

extension FriendsDisconnectView: FriendViewRepresentable {
    func setup(with viewModel: FriendsViewModelRepresentable, with friendsList: [GetFriendsEntity]) {
        self.viewModel = viewModel
    }
}
