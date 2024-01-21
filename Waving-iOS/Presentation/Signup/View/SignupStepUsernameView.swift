//
//  SignupStepUsernameView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/10.
//

import UIKit
import Combine

final class SignupStepUsernameView: UIView {
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private var usernameText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var isValidTextfieldValues: Bool {
        isValidUsername
    }
    
    /// to validate a username with at least 2 characters including English and Korean
    private var isValidUsername: Bool {
        guard !usernameText.isEmpty && usernameText.count > 1 && usernameText.count < 9 else { return false }
        
        let usernameRegex = "^[a-zA-Z가-힣]{2,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let result = usernameTest.evaluate(with: usernameText)
        Log.d("userNameTest: \(result), text: \(usernameText)")
        return result
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
        
        let usernameFieldContainer = SignupTextFieldContainer(with: .username)
        usernameFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        usernameFieldContainer.textField.delegate = self
        usernameFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(usernameFieldContainer)
        usernameFieldContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
//        let textLabel = UILabel()
//        textLabel.text = "2~8자 사이로 입력하세요."
//        textLabel.textColor = .gray030
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(textLabel)
//        textLabel.snp.makeConstraints {
//            $0.top.equalTo(usernameFieldContainer.snp.bottom).offset(10)
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .username:
            usernameText = text
            viewModel?.updateUsername(text)
        default:
            Log.d("default")
        }
        
        viewModel?.isNextButtonEnabled = isValidTextfieldValues
    }
}

extension SignupStepUsernameView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}

extension SignupStepUsernameView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
}
