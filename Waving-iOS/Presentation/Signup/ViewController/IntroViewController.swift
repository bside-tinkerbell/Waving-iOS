//
//  IntroViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/02.
//

import UIKit
import Combine

extension IntroRoute {
    fileprivate var viewController: UIViewController {
        switch self {
        case .signupView:
            return SignupViewController()
        case .loginView:
            return LoginViewController()
        }
    }
}

final class IntroViewController: UIViewController {
    
    private let viewModel = IntroViewModel()
    
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
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        binding()
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
            make.width.equalTo(Constants.Intro.loginButtonWidth)
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
        logoLabel.font = .p_M(40)
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
    
    private func binding() {
        viewModel.route
            .sink { [weak self] route in
                self?.navigationController?.pushViewController(route.viewController, animated: true)
            }
            .store(in: &cancellable)
    }

}
