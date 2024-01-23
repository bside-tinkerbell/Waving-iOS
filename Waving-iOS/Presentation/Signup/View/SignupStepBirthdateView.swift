//
//  SignupStepBirthdateView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/10.
//

import UIKit
import Combine

final class SignupStepBirthdateView: UIView {
    
    var viewModel: SignupStepViewModelRepresentable?
    
    private var birthdateText: String = ""
    
    private var cancellables = [AnyCancellable]()
    
    private var isValidTextfieldValues: Bool {
        isValidBirthdate
    }
    
    private let textLabel: UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
                    만약 본인의 생년월일을 제공하고 싶지 않다면
                    위의 입력칸에 1990-01-01이라고 써주세요
                    (‼️제발 형식 지켜주세요‼️)
                    """
        return label
    }()
    
    private var isValidBirthdate: Bool {
        !birthdateText.isEmpty && BirthdateFormatter.isValidBirthdate(birthdateText)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        let birthdateFieldContainer = SignupTextFieldContainer(with: .birthdate)
        birthdateFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        birthdateFieldContainer.textField.delegate = self
        birthdateFieldContainer.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        containerView.addSubview(birthdateFieldContainer)
        birthdateFieldContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .birthdate:
            birthdateText = text
        default:
            Log.d("default")
        }
        
        viewModel?.isNextButtonEnabled = isValidTextfieldValues
    }
}

extension SignupStepBirthdateView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
        
        self.viewModel?.nextButtonAction = { [weak self] in
            guard let self else { return }
            self.viewModel?.updateBirthdate(self.birthdateText)
        }
    }
}

extension SignupStepBirthdateView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        Log.d("text: \(text)")
    }
}
