//
//  SignupStepEmailPasswordView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit

final class SignupStepEmailPasswordView: UIView {

    let viewModel = SignupStepEmailPasswordViewModel()
    
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
        
        let emailTextFieldContainer = SignupTextFieldContainer(with: .email)
        emailTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldContainer.textField.delegate = self
        emailTextFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(emailTextFieldContainer)
        emailTextFieldContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let passwordTextfieldContainer = SignupTextFieldContainer(with: .password)
        passwordTextfieldContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(passwordTextfieldContainer)
        passwordTextfieldContainer.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldContainer.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let passwordConfirmTextFieldContainer = SignupTextFieldContainer(with: .passwordConfirm)
        passwordConfirmTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(passwordConfirmTextFieldContainer)
        passwordConfirmTextFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfieldContainer.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .email:
            self.viewModel.updateEmail(text)
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


