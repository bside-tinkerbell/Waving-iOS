//
//  FriendsIntroView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/24.
//

import UIKit
import Combine

class FriendsIntroView: UIView, SnapKitInterface {
    
    var viewModel: FriendsViewModelRepresentable?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(string: "소중한 지인을 추가하고,\n연락해보세요.")
            .wv_setFont(.p_B(24))
            .wv_setTextColor(UIColor(hex: "1B1B1B"))
        return label
    }()
    
    private let subLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(string: "소중한 지인과의 연락을 기록하고,\n상황에 맞는 인사말을 추천해드려요.")
            .wv_setFont(.p_R(16))
            .wv_setTextColor(.Text.text050)
        return label
    }()
    
    private let vingvingImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doordog")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let friendsAddButton = WVButton()
    private lazy var friendAddButtonViewModel = WVButtonModel(title: "지인 불러오기", titleColor: .Text.white, backgroundColor: .Button.mainBlackButton) { [weak self] in
        if LoginDataStore.shared.userId != nil {
            self?.viewModel?.addFriends()
        } else {
            let toast = Toast()
            lazy var toastModel: ToastModel = .init(title: ToastMessage.signInMessage.rawValue)
            toast.setupView(model: toastModel)
            
            guard let vc = UIApplication.getMostTopViewController() else {return}
            guard let navi = vc.navigationController else {return}
            
            navi.view.addSubview(toast)
            toast.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
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
        [titleLabel, subLabel, vingvingImage, friendsAddButton].forEach { containerView.addSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.right.equalToSuperview().offset(24)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().offset(24)
        }
        
        vingvingImage.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(134)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(194)
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

extension FriendsIntroView: FriendViewRepresentable {
    func setup(with viewModel: FriendsViewModelRepresentable, with friendsList: [GetFriendsEntity]) {
        self.viewModel = viewModel
    }
}
