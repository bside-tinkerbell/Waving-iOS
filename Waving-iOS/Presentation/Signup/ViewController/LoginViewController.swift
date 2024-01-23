//
//  LoginViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import Combine
import UIKit

final class LoginViewController: UIViewController, SnapKitInterface {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let viewModel = LoginViewModel()
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    lazy private var emailTextFieldContainer: SignupTextFieldContainer = {
        let textField = SignupTextFieldContainer(with: .email)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy private var passwordTextFieldContainer: SignupTextFieldContainer = {
        let textField = SignupTextFieldContainer(with: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy private var doneButtonModel = WVButtonModel(title: "로그인", isEnabled: false, titleColor: .Text.white, backgroundColor: .Button.mainBlackButton) { [weak self] in
        self?.viewModel.login()
    }
    
    lazy private var doneButton: WVButton = {
        let button = WVButton()
        button.setup(model: doneButtonModel)
        return button
    }()
    
    private var emailText: String = ""
    private var passwordText: String = ""
    
    private var isValidEmail: Bool {
        !emailText.isEmpty
    }
    
    private var isValidPassword: Bool {
        !passwordText.isEmpty && passwordText.count > 7
    }
    
    private var isDoneButtonEnabled: Bool {
        isValidEmail && isValidPassword
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        addComponents()
        setConstraints()
        binding()
    }
    
    private func setupView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func textFieldDidChange(_ textField: WVTextField) {
        guard let text = textField.text else { return }
        
        switch textField.type {
        case .email:
            emailText = text
            viewModel.updateEmail(text)
        case .password:
            passwordText = text
            viewModel.updatePassword(text)
        default:
            Log.d("default")
        }
        
        doneButton.isEnabled = isDoneButtonEnabled
    }
    
    func addComponents() {
        [containerView].forEach { view.addSubview($0) }
        [textFieldStackView].forEach { containerView.addSubview($0) }
        [emailTextFieldContainer, passwordTextFieldContainer, doneButton].forEach { textFieldStackView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func binding() {
//        viewModel.route
//            .sink { [weak self] route in
//                self?.navigationController?.pushViewController(route.viewController, animated: true)
//            }
//            .store(in: &cancellable)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: emailTextFieldContainer.textField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .sink { [weak self] in
                guard let self else { return }
                emailText = $0
                viewModel.emailPublisher.send($0)
                doneButton.isEnabled = isDoneButtonEnabled
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextFieldContainer.textField)
            .dropFirst()
            .map { ($0.object as? UITextField)?.text ?? "" }
            .sink { [weak self] in
                guard let self else { return }
                passwordText = $0
                viewModel.passwordPublisher.send($0)
                doneButton.isEnabled = isDoneButtonEnabled
            }
            .store(in: &cancellables)
    }
}
