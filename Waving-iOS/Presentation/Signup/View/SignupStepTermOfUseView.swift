//
//  SignupStepTermOfUseView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/16.
//

import UIKit
import Combine

final class SignupStepTermOfUseView: UIView {
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private var cancellables = [AnyCancellable]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        let labelContainerView = UIView()
        let label = UILabel().then {
            $0.font = .p_R(18)
            $0.textColor = .text090
            $0.numberOfLines = 1
            $0.text = "이용 약관에 동의해주세요."
        }
        labelContainerView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        stackView.addArrangedSubview(labelContainerView)
        
        let button = SignupTermsOfUseButton()
        stackView.addArrangedSubview(button)
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
//        guard let text = textField.text else { return }
//        
//        switch textField.type {
//        default:
//            Log.d("default")
//        }
    }
}

extension SignupStepTermOfUseView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}

extension SignupStepTermOfUseView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
}
