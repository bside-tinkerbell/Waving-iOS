//
//  HomeNavigationView.swift
//  Waving-iOS
//
//  Created by USER on 2023/07/14.
//

import UIKit

final class HomeNavigationView: UIView, SnapKitInterface {
    
    
    // MARK: - View
    private lazy var logoButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "icn_home_logo"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "icn_alarm_on"), for: .normal)
        return button
    }()
    
    private lazy var paddingView: UIView = {
       UIView()
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.Navi.commonPadding
        return stackView
    }()
    
    private var model: NavigationModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(logoButton)
        buttonStackView.addArrangedSubview(paddingView)
//        buttonStackView.addArrangedSubview(rightButton)
    }
    
    func setConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview()
            $0.height.equalTo(Constants.Navi.defaultHeight)
        }
        
//        logoButton.snp.makeConstraints {
//            $0.width.equalTo(Constants.Home.logoSize.width)
//            $0.height.equalTo(Constants.Home.logoSize.height)
//        }
//        
//        rightButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.size.equalTo(Constants.Home.rightButtonSize.width)
//        }
    }
}
