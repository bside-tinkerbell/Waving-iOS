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
        case .mainTabView:
            return MainTabBarController()
        }
    }
}

final class IntroViewController: UIViewController {
    
    private let viewModel = IntroViewModel()
    
    private lazy var signupButtonViewModel = WVButtonModel(title: "가입하기", titleColor: .Text.white, backgroundColor: .Button.mainBlackButton) { [weak self] in
        self?.viewModel.signup()
    }

    private lazy var loginButtonViewModel = WVButtonModel(title: "이메일로 로그인", titleColor: .Text.text090, backgroundColor: .white, borderColor: .Border.gray) { [weak self] in
        self?.viewModel.login()
    }
    
    private lazy var tourButtonViewModel = WVButtonModel(title: "게스트로 둘러 보기", titleColor: .Text.text090, backgroundColor: .Button.mainButton, borderColor: .Border.gray) { [weak self] in
        self?.viewModel.tour()
    }
    
    private let logoStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .Main.main050
        stackView.axis = .vertical
        stackView.spacing = 8
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
        view.backgroundColor = .Main.main050
        
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
        logoImageView.snp.makeConstraints { $0.top.bottom.centerX.equalToSuperview() }
        
        let logoLabel = UILabel()
        logoLabel.textColor = .Text.black
        logoLabel.text = "연락이 망설여진다면,"
        logoLabel.font = .p_M(16)
        logoLabel.textAlignment = .center
        logoStackView.alignment = .center
        
        let textContainerView = UIView()
        let textImageView = UIImageView(image: UIImage(named: "img_logo"))
        textContainerView.addSubview(textImageView)
        textImageView.snp.makeConstraints { $0.top.bottom.centerX.equalToSuperview() }
        [imageContainerView, logoLabel, textContainerView].forEach{logoStackView.addArrangedSubview($0)}
    }
    
    private func setupButtons() {
        let signupButton = WVButton()
        signupButton.setup(model: signupButtonViewModel)
        
        let loginButton = WVButton()
        loginButton.setup(model: loginButtonViewModel)
        
        let tourButton = WVButton()
        tourButton.setup(model: tourButtonViewModel)

        buttonStackView.spacing = Constants.Intro.buttonSpacing
        [signupButton, loginButton, tourButton].forEach{ buttonStackView.addArrangedSubview($0) }
    }
    
    private func binding() {
        viewModel.route
            .sink { [weak self] route in
                self?.navigationController?.pushViewController(route.viewController, animated: true)
            }
            .store(in: &cancellable)
    }

}
