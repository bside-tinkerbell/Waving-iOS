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
    
    private var inValidTextfieldValues: Bool {
        isValidUsername
    }
    
    private var isValidUsername: Bool {
        !usernameText.isEmpty && usernameText.count > 1 && usernameText.count < 9
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
        
        viewModel?.isNextButtonEnabled = true
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
