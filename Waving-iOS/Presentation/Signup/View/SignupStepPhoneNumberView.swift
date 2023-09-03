//
//  SignupStepPhoneNumberView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/10.
//

import UIKit
import Combine

final class SignupStepPhoneNumberView: UIView {
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private let authCodeButtonModel = WVButtonModel(title: "인증번호") {
        // 인증번호 요청
        Log.d("인증번호 요청")
    }
    private var authCodeButton: WVButton?
    
    private var authCodeTextFieldContainer: SignupTextFieldContainer?
    
    private var phoneNumberText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var isValidTextfieldValues: Bool {
        let result = isValidPhoneNumber
        Log.d("result: \(result)")
        return result
    }
    
    private var isValidPhoneNumber: Bool {
        !phoneNumberText.isEmpty && phoneNumberText.count > 0 && phoneNumberText.count < 9
    }
    
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
        
        let phoneNumberRowStackView = UIStackView()
        phoneNumberRowStackView.axis = .horizontal
        phoneNumberRowStackView.spacing = 16
        containerView.addSubview(phoneNumberRowStackView)
        
        let phoneNumberFieldContainer = SignupTextFieldContainer(with: .phoneNumber)
        phoneNumberFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberFieldContainer.textField.delegate = self
        phoneNumberFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        phoneNumberFieldContainer.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        phoneNumberRowStackView.addArrangedSubview(phoneNumberFieldContainer)

        phoneNumberRowStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let authCodeRequestButtonContainerView = UIView()
        let authCodeRequestButton = WVButton()
        authCodeButton = authCodeRequestButton
        authCodeRequestButtonContainerView.addSubview(authCodeRequestButton)
        authCodeRequestButton.setup(model: authCodeButtonModel)
        authCodeRequestButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        phoneNumberRowStackView.addArrangedSubview(authCodeRequestButtonContainerView)
        authCodeRequestButton.snp.makeConstraints { make in
            make.top.equalToSuperview().priority(.low)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let authCodeTextFieldContainer = SignupTextFieldContainer(with: .authCode)
        self.authCodeTextFieldContainer = authCodeTextFieldContainer
        authCodeTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        authCodeTextFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(authCodeTextFieldContainer)
        authCodeTextFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberRowStackView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .phoneNumber:
            phoneNumberText = text
            viewModel?.updatePhoneNumber(text)
            if !text.isEmpty {
                authCodeButton?.isEnabled = true
            }
            
        default:
            Log.d("default")
        }
        
        viewModel?.isNextButtonEnabled = isValidTextfieldValues
    }
}

extension SignupStepPhoneNumberView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}

extension SignupStepPhoneNumberView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
}
