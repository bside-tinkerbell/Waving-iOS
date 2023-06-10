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
    
    private var authCodeTextFieldContainer: SignupTextFieldContainer?
    
    private var phoneNumberText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var inValidTextfieldValues: Bool {
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
        
        let usernameFieldContainer = SignupTextFieldContainer(with: .phoneNumber)
        usernameFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        usernameFieldContainer.textField.delegate = self
        usernameFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(usernameFieldContainer)
        usernameFieldContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let authCodeTextFieldContainer = SignupTextFieldContainer(with: .authCode)
        self.authCodeTextFieldContainer = authCodeTextFieldContainer
        authCodeTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        authCodeTextFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(authCodeTextFieldContainer)
        authCodeTextFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(usernameFieldContainer.snp.bottom)
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
        default:
            Log.d("default")
        }
        
        viewModel?.isNextButtonEnabled = inValidTextfieldValues
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
