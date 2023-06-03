//
//  SignupViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/02.
//

import UIKit

final class SignupViewController: UIViewController {
    
    private let viewModel = SignupViewModel()
    
    private lazy var signupButtonViewModel = WVButtonModel(title: "가입하기", titleColor: .Text.white, backgroundColor: .Button.blackBackground) { [weak self] in
        self?.viewModel.signup()
    }

    private lazy var loginButtonViewModel = WVButtonModel(title: "이메일로 로그인", backgroundColor: .clear, borderColor: .Border.gray) { [weak self] in
        self?.viewModel.login()
    }
    
    private let logoStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let buttonStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .Background.white
        
        setupLogo()
        setupButtons()
        
        let containerView = UIView()
        containerView.addSubview(buttonStackView)
        containerView.addSubview(logoStackView)
        
        logoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(buttonStackView.snp.top).offset(-140)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        buttonStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupLogo() {
        let imageContainerView = UIView()
        let logoImageView = UIImageView()
        if let image = UIImage(named: "intro_logo") {
            logoImageView.image = image
        }
        imageContainerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let logoLabel = UILabel()
        logoLabel.textColor = .Text.black
        logoLabel.text = "waving"
        logoLabel.font = .systemFont(ofSize: 40, weight: .medium)
        logoLabel.textAlignment = .center
        
        logoStackView.alignment = .center
        logoStackView.addArrangedSubview(imageContainerView)
        logoStackView.addArrangedSubview(logoLabel)
    }
    
    private func setupButtons() {
        let signupButton = WVButton()
        signupButton.setup(model: signupButtonViewModel)
        
        let loginButton = WVButton()
        loginButton.setup(model: loginButtonViewModel)

        buttonStackView.spacing = Constants.Intro.buttonSpacing
        buttonStackView.addArrangedSubview(signupButton)
        buttonStackView.addArrangedSubview(loginButton)
    }

}

final class SignupViewModel {
    
    func signup() {
        // show signup view controller
        Log.d("가입")
    }
    
    func login() {
        // show login view controller
        Log.d("로그인")
    }
}
