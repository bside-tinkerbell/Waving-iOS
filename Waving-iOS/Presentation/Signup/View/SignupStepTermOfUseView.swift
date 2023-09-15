//
//  SignupStepTermOfUseView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/16.
//

import UIKit
import Combine

final class SignupStepTermOfUseView: UIView, SnapKitInterface {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var titleLabelContainerView: UIView = {
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
        return labelContainerView
    }()
    
    private lazy var firstButtonModel: SignupTermsOfUseButtonModel = .init(title: "[필수] 이용약관(만 14세 이상 이용가능)") { [weak self] _ in
        guard let self else { return }
        
        let isNextButtonEnabled = self.firstButtonModel.isSelected && self.secondButtonModel.isSelected
        self.viewModel?.isNextButtonEnabled = isNextButtonEnabled
    }
    
    private lazy var secondButtonModel: SignupTermsOfUseButtonModel = .init(title: "[필수] 개인정보 수집 및 이용") { [weak self] _ in
        guard let self else { return }
        
        let isNextButtonEnabled = self.firstButtonModel.isSelected && self.secondButtonModel.isSelected
        self.viewModel?.isNextButtonEnabled = isNextButtonEnabled
    }

    private lazy var agreeAllButtonModel: SignupTermsOfUseButtonModel = .init(title: "약관 전체동의", showBottomSeparator: true, didTouchUpInside: { [weak self] _ in
        guard let self else { return }
        self.firstButtonModel.isSelected = !self.firstButtonModel.isSelected
        self.secondButtonModel.isSelected = !self.secondButtonModel.isSelected
        
        self.viewModel?.isNextButtonEnabled = true
    })
    
    private lazy var firstButton: SignupTermsOfUseButton = {
        let button = SignupTermsOfUseButton()
        button.setup(model: firstButtonModel)
        return button
    }()
    private lazy var secondButton: SignupTermsOfUseButton = {
        let button = SignupTermsOfUseButton()
        button.setup(model: secondButtonModel)
        return button
    }()
    private lazy var agreeAllButton: SignupTermsOfUseButton = {
        let button = SignupTermsOfUseButton()
        button.setup(model: agreeAllButtonModel)
        return button
    }()
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private var cancellables = [AnyCancellable]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabelContainerView)
        stackView.addArrangedSubview(agreeAllButton)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func signup() {
        guard let email = SignDataStore.shared.email,
              let password = SignDataStore.shared.password,
              let username = SignDataStore.shared.username,
              let birthday = SignDataStore.shared.formattedBirthdate,
              let phoneNumber = SignDataStore.shared.formattedPhoneNumber else { return }
        
        let signRequestModel = SignRequestModel(gatherAgree: 1, email: email, password: password, loginType: 0, name: username, birthday: birthday, cellphone: phoneNumber)
        
        SignAPI.signup(model: signRequestModel) { succeed, failed in
            if failed != nil {
                Log.d("sign up failed")
                return
            }
            
            guard let succeed else { return }
            Log.d("signup succeeded: \(succeed.result)")
        }
    }
}

extension SignupStepTermOfUseView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
        
        self.viewModel?.isNextButtonEnabled = false
        self.viewModel?.nextButtonAction = { [weak self] in
            guard let self else { return }
            self.signup()
        }
    }
}
