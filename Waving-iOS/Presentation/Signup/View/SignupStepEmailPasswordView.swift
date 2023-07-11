//
//  SignupStepEmailPasswordView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit
import Combine

final class SignupStepEmailPasswordView: UIView {
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private var passwordConfirmTextFieldContainer: SignupTextFieldContainer?
    
    private var emailText: String = ""
    private var passwordText: String = ""
    
    @Published private var passwordConfirmText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var isValidTextfieldValues: Bool {
        let result = isValidEmail && isValidPassword
        Log.d("result: \(result), emali: \(emailText), password: \(passwordText)")
        return result
    }
    
    private var isValidEmail: Bool {
        !emailText.isEmpty && emailText.isValidEmail
    }
    
    private var isValidPassword: Bool {
        passwordText.count > 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupNotification()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotification() {
        
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
        passwordTextfieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(passwordTextfieldContainer)
        passwordTextfieldContainer.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldContainer.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let passwordConfirmTextFieldContainer = SignupTextFieldContainer(with: .passwordConfirm)
        self.passwordConfirmTextFieldContainer = passwordConfirmTextFieldContainer
        passwordConfirmTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmTextFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(passwordConfirmTextFieldContainer)
        passwordConfirmTextFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfieldContainer.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        self.$passwordConfirmText
            .sink { [weak self] passwordConfirmText in
                guard let self else { return }
                let isSamePasswordConfirmText = self.passwordText != passwordConfirmText
                self.passwordConfirmTextFieldContainer?.isWarning = isSamePasswordConfirmText
                
                if isSamePasswordConfirmText {
                    
                }
                
            }
            .store(in: &cancellables)
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .email:
            emailText = text
            viewModel?.updateEmail(text)
        case .password:
            passwordText = text
        case .passwordConfirm:
            passwordConfirmText = text
            viewModel?.updatePassword(text)
        default:
            Log.d("default")
        }
        
        viewModel?.isNextButtonEnabled = isValidTextfieldValues
    }
}

extension SignupStepEmailPasswordView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}

extension SignupStepEmailPasswordView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
}


