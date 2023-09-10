//
//  SignupStepPhoneNumberView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/10.
//

import UIKit
import Combine

final class SignupStepPhoneNumberView: UIView {
    
    private enum SubStep: Int {
        case requestAuthCode
        case confirmAuthCode
    }
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private let authCodeButtonModel = WVButtonModel(title: "인증번호", backgroundColor: .mainButton) {
        // 인증번호 요청
        guard let phoneNumber = SignDataStore.shared.phoneNumber else { return }
        
        SignAPI.requestAuthCode(cellphone: phoneNumber) { succeed, failed in
            if let failed {
                Log.d("Auth code request failed: \(failed)")
                return
            }
            
            guard let succeed else { return }
            Log.d("result: \(succeed.result)")
        }

    }
    
    private var authCodeButton: WVButton?
    
    fileprivate var authCodeTextFieldContainer: SignupTextFieldContainer?
    fileprivate var phoneNumberFieldContainer: SignupTextFieldContainer?
    
    private var phoneNumberText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var isValidTextfieldValues: Bool {
        let result = isValidPhoneNumber
        return result
    }
    
    private var isValidPhoneNumber: Bool {
        !phoneNumberText.isEmpty && phoneNumberText.count > 0 && phoneNumberText.count <= PhoneNumberFormatter.phoneNumberMaxLength
    }
    
    private var subStep: SubStep = .requestAuthCode
    
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
        self.phoneNumberFieldContainer = phoneNumberFieldContainer
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
        authCodeRequestButtonContainerView.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
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
            let formattedPhoneNumber = PhoneNumberFormatter.format(text: text)
            textField.text = formattedPhoneNumber
            phoneNumberText = text
            viewModel?.updatePhoneNumber(text)
        default:
            Log.d("default")
        }
        
        if subStep == .requestAuthCode {
            viewModel?.isNextButtonEnabled = isValidTextfieldValues
        } else {
            
        }
    }
}

extension SignupStepPhoneNumberView: UITextFieldDelegate {
    
}

extension SignupStepPhoneNumberView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}

struct PhoneNumberFormatter {
    
    static let phoneNumberMaxLength: Int = 13   // hyphen 포함
    static let phoneNumberRequiredString = "010"
    static let hyphen = "-"
    
    static func format(text: String) -> String {
        if (text.count == 3 && text == phoneNumberRequiredString) {
            return text + hyphen
        }
        
        if text.count == 12 {
            let mutablePhoneNumber = NSMutableString(string: text)
            mutablePhoneNumber.replaceOccurrences(of: hyphen, with: "", range: .init(location: 0, length: text.count))
            mutablePhoneNumber.insert(hyphen, at: 3)
            mutablePhoneNumber.insert(hyphen, at: 8)
            return String(mutablePhoneNumber)
        }
        
        if text.count == 13 {
            let mutablePhoneNumber = NSMutableString(string: text)
            mutablePhoneNumber.replaceOccurrences(of: hyphen, with: "", range: .init(location: 0, length: text.count))
            mutablePhoneNumber.insert(hyphen, at: 3)
            mutablePhoneNumber.insert(hyphen, at: 8)
            return String(mutablePhoneNumber)
        }
        
        if text.count > phoneNumberMaxLength {
            return String(text.prefix(phoneNumberMaxLength))
        }
        
        return text
    }
}
