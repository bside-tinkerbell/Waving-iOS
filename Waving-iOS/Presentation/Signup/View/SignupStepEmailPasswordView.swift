//
//  SignupStepEmailPasswordView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit

final class SignupStepEmailPasswordView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        let label = UILabel().then {
            $0.text = "이메일"
            $0.font = .p_R(18)
            $0.textColor = .text090
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        label.numberOfLines = 1
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let textField = SignupTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.delegate = self
        containerView.addSubview(textField)
        textField.textField.placeholder = "ex) waving@naver.com"
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(22)
            make.bottom.equalToSuperview()
        }
    }

}
