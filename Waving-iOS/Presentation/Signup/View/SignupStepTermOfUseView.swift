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
    
    private lazy var firstButtonModel: SignupTermsOfUseButtonModel = .init(title: "[필수] 이용약관(만 14세 이상 이용가능)")
    private lazy var secondButtonModel: SignupTermsOfUseButtonModel = .init(title: "[필수] 개인정보 수집 및 이용")
    private lazy var agreeAllButtonModel: SignupTermsOfUseButtonModel = .init(title: "약관 전체동의", showBottomSeparator: true, didTouchUpInside: { [weak self] _ in
        guard let self else { return }
        self.firstButtonModel.isSelected = !self.firstButtonModel.isSelected
        self.secondButtonModel.isSelected = !self.secondButtonModel.isSelected
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
}

extension SignupStepTermOfUseView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
    }
}
