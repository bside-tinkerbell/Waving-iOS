//
//  SignupStepEmailPasswordView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit

final class SignupStepEmailPasswordView: UIView {

    var viewModel: SignupStepViewModel?
    
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
        
        let textFieldContainer = SignupTextFieldContainer()
        textFieldContainer.textField.type = .email
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainer.textField.delegate = self
        textFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(textFieldContainer)
        textFieldContainer.textField.placeholder = "ex) waving@naver.com"
        textFieldContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(22)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .email:
            self.viewModel?.updateEmail(text)
        default:
            Log.d("default")
        }
    }
}

extension SignupStepEmailPasswordView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Log.d("string: \(string)")
        return true
    }
}


