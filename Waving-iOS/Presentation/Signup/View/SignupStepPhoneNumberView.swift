//
//  SignupStepPhoneNumberView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/10.
//

import UIKit
import Combine

final class SignupStepPhoneNumberView: UIView {
    /// 앱 심사 리뷰어에게 제공하는 휴대폰 번호
    private static let phoneNumberForReviewer: String = "010-0000-0000"
    /// 앱 심사 리뷰어에게 제공하는 인증코드
    private static let authCodeForReviewer: String = "00000"
    
    private enum SubStep: Int {
        case requestAuthCode
        case confirmAuthCode
    }
    
    var viewModel: SignupStepViewModelRepresentable?
    
    lazy private var authCodeRequestButtonModel = WVButtonModel(title: "인증번호", isEnabled: false, backgroundColor: .Button.mainBlackButton) { [weak self] in
        guard let self, let phoneNumber = SignDataStore.shared.formattedPhoneNumber else { return }
    
        Log.d("phoneNumber: \(phoneNumber), self: \(self)")
        
        // 앱 심사 리뷰어를 위한 코드
        if phoneNumber == Self.phoneNumberForReviewer {
            Log.d("Phone number for reviewer: \(phoneNumber)")
            phoneNumberFieldContainer?.textField.isEnabled = false
            authCodeRequestButton?.isEnabled = false
            self.subStep = .confirmAuthCode
            self.viewModel?.isNextButtonEnabled = false
            return
        }
        
        // 인증번호 요청
        SignAPI.requestAuthCode(cellphone: phoneNumber) { [weak self] succeed, failed in
            if let failed {
                Log.d("Auth code request failed: \(failed)")
                return
            }
            
            guard let self, let succeed else { return }
            Log.d("result: \(succeed.result)")
            phoneNumberFieldContainer?.textField.isEnabled = false
            authCodeRequestButton?.isEnabled = false
            subStep = .confirmAuthCode
            viewModel?.isNextButtonEnabled = false
        }
    }
    
    lazy private var authCodeConfirmButtonModel = WVButtonModel(title: "확인", isEnabled: false, backgroundColor: .Button.mainBlackButton) { [weak self] in
        guard let self,
              let phoneNumber = SignDataStore.shared.phoneNumber,
              let authCode = Int(self.authCodeText) else { return }
        
        let formattedPhoneNumber = PhoneNumberFormatter.format(text: phoneNumber)
        
        // 앱 심사 리뷰어를 위한 코드
        if phoneNumber == Self.phoneNumberForReviewer {
            Log.d("Auth code for reviewer: \(authCodeText)")
            if authCodeText == Self.authCodeForReviewer {
                self.viewModel?.isNextButtonEnabled = true
            }
            return
        }
        
        // 인증번호 검증
        SignAPI.confirmAuthCode(cellphone: formattedPhoneNumber, authCode: authCode, completion: { succeed, failed in
            if let failed {
                Log.d("Auth code confirm failed: \(failed)")
                return
            }
            
            guard let succeed else { return }
            Log.d("result: \(succeed.result)")
            self.viewModel?.isNextButtonEnabled = true
        })
    }
    
    private var authCodeRequestButton: WVButton?
    private var authCodeConfirmButton: WVButton?
    private var authCodeConfirmButtonContainerVier: UIView?
    
    fileprivate var authCodeTextFieldContainer: SignupTextFieldContainer?
    fileprivate var phoneNumberFieldContainer: SignupTextFieldContainer?
    
    private var phoneNumberText: String = ""
    private var authCodeText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private func isValidText(_ text: String) -> Bool {
        if subStep == .requestAuthCode {
            return !text.isEmpty && text.count > 0 && text.count <= PhoneNumberFormatter.phoneNumberMaxLength && isValidPhoneNumber(phoneNumber: text)
        } else if subStep == .confirmAuthCode {
            return !text.isEmpty && text.count == 5
        }
        
        return false
    }
    
    private func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegex = #"^010-\d{3,4}-\d{4}$"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: phoneNumber)
        Log.d("isValidPhoneNumber: \(result)")
        return result
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
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        let phoneNumberRowStackView = UIStackView()
        phoneNumberRowStackView.axis = .horizontal
        phoneNumberRowStackView.spacing = 16
        containerStackView.addArrangedSubview(phoneNumberRowStackView)
        
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
        
        self.authCodeRequestButton = authCodeRequestButton
        authCodeRequestButtonContainerView.addSubview(authCodeRequestButton)
        authCodeRequestButton.setup(model: authCodeRequestButtonModel)
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
        
        let authCodeRowStackView = UIStackView()
        authCodeRowStackView.axis = .horizontal
        authCodeRowStackView.spacing = 16
        containerStackView.addArrangedSubview(authCodeRowStackView)
        
        let authCodeTextFieldContainer = SignupTextFieldContainer(with: .authCode)
        self.authCodeTextFieldContainer = authCodeTextFieldContainer
        authCodeTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        authCodeTextFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        authCodeRowStackView.addArrangedSubview(authCodeTextFieldContainer)
        
        let authCodeConfirmButtonContainerView = UIView()
        let authCodeConfirmButton = WVButton()
        
        self.authCodeConfirmButton = authCodeConfirmButton
        self.authCodeConfirmButtonContainerVier = authCodeConfirmButtonContainerView
        authCodeConfirmButtonContainerView.addSubview(authCodeConfirmButton)
        authCodeConfirmButton.setup(model: authCodeConfirmButtonModel)
        authCodeConfirmButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        authCodeRowStackView.addArrangedSubview(authCodeConfirmButtonContainerView)
        authCodeConfirmButtonContainerView.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
        authCodeConfirmButton.snp.makeConstraints { make in
            make.top.equalToSuperview().priority(.low)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        let isValid = isValidText(text)
        
        switch textField.type {
        case .phoneNumber:
            phoneNumberText = text
            viewModel?.updatePhoneNumber(text)
            authCodeRequestButton?.isEnabled = isValid
        case .authCode:
            authCodeText = text
            authCodeConfirmButton?.isEnabled = isValid
        default:
            Log.d("default")
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
        
        if text.count == 10 {
            Log.d("text length: \(text.count). text: \(text)")
            let mutablePhoneNumber = NSMutableString(string: text)
            mutablePhoneNumber.replaceOccurrences(of: hyphen, with: "", range: .init(location: 0, length: text.count))
            mutablePhoneNumber.insert(hyphen, at: 3)
            mutablePhoneNumber.insert(hyphen, at: 7)
            return String(mutablePhoneNumber)
        }
        
        if text.count == 11 {
            Log.d("text length: \(text.count). text: \(text)")
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
