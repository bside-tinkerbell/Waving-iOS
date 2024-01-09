//
//  SignupTextField.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit
import Combine

/// 회원가입 화면에서 공통으로 사용하는 회원정보 입력 필드
final class SignupTextFieldContainer: UIView {

    @Published var textFieldType: SignupTextFieldType?
    @Published var isWarning = false
    @Published var isEmpty = true
    
    private(set) var textField: WVTextField!
    private(set) var titleLabel: UILabel!
    private var titleLabelContainerView: UIView!
    private var bottomSeparator: UIView!
    private var cancellables = [AnyCancellable]()
    
    init(with textFieldType: SignupTextFieldType) {
        self.textFieldType = textFieldType
        
        super.init(frame: .zero)
        
        setupView()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 22
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let labelContainerView = UIView()
        titleLabelContainerView = labelContainerView
        let label = UILabel().then {
            $0.font = .p_R(18)
            $0.textColor = .Text.text090
            $0.numberOfLines = 1
        }
        titleLabel = label
        labelContainerView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        stackView.addArrangedSubview(labelContainerView)
        
        self.textField = {
            let textField = WVTextField()
            textField.textColor = .Text.text090
            textField.font = .p_R(18)
            textField.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(textField)
            
            return textField
        }()
        
        self.bottomSeparator = {
            let view = UIView()
            view.backgroundColor = .Text.text090
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            view.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.top.equalTo(stackView.snp.bottom).offset(8)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            return view
        }()
    }
    
    private func binding() {
        self.$textFieldType
            .sink { [weak self] in
                guard let self, let type = $0 else { return }
                self.textField.type = type
                self.titleLabel.text = type.textFieldTitle
                self.titleLabelContainerView.isHidden = (type.textFieldTitle == nil)
                self.textField.placeholder = type.placeholder
            }
            .store(in: &cancellables)
        
        self.$isWarning
            .sink { [weak self] in
                guard let self else { return }
                let color: UIColor = $0 ? .Text.caution050 : .gray090
                self.textField.textColor = color
                self.bottomSeparator.backgroundColor = color
            }
            .store(in: &cancellables)
    }
}

