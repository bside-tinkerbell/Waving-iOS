//
//  SignupTextField.swift
//  Waving-iOS
//
//  Created by USER on 2023/06/08.
//

import UIKit

/// 회원가입 화면에서 공통으로 사용하는 회원정보 입력 필드
final class SignupTextField: UIView {

    private(set) var textField: UITextField!
    private var bottomSeparator: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        
        self.textField = {
            let textField = UITextField()
            textField.textColor = .text090
            textField.font = .p_R(18)
            textField.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: self.topAnchor),
                textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                textField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            
            return textField
        }()
        
        self.bottomSeparator = {
            let view = UIView()
            view.backgroundColor = .text090
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 1),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            
            return view
        }()
    }
}

