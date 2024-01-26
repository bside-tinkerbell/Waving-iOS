//
//  SignupStepCompleteView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/24.
//

import UIKit
import Combine

final class SignupStepCompleteView: UIView, SnapKitInterface {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "signup_complete")
        return UIImageView(image: image)
    }()
    
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel().then {
            $0.font = .p_M(24)
            $0.textColor = .gray090
            $0.numberOfLines = 2
            $0.text = "회원 가입이 완료됐습니다\n만나서 반가워요 👋🏻"
        }
        return label
    }()
    private lazy var titleLabelContainerView: UIView = {
        let labelContainerView = UIView()
        let label = UILabel().then {
            $0.font = .p_M(24)
            $0.textColor = .gray090
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.text = "회원 가입이 완료됐습니다\n만나서 반가워요 👋🏻"
        }
        labelContainerView.addSubview(label)
        
        return labelContainerView
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
        imageContainerView.addSubview(imageView)
        titleLabelContainerView.addSubview(titleLabel)
        
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(titleLabelContainerView)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(75)
            $0.trailing.equalToSuperview().offset(-75)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    func signup() {
        guard let email = SignDataStore.shared.email,
              let password = SignDataStore.shared.password,
              let username = SignDataStore.shared.username,
              let birthday = SignDataStore.shared.formattedBirthdate,
              let phoneNumber = SignDataStore.shared.formattedPhoneNumber else { return }
        
        let signRequestModel = SignRequestModel(gatherAgree: 1, email: email, password: password, loginType: 0, name: username, birthday: "2000-01-01", cellphone: phoneNumber)
        
        SignAPI.signup(model: signRequestModel) { succeed, failed in
            if failed != nil {
                Log.d("sign up failed")
                return
            }
            
            guard let succeed else { return }
            Log.d("signup succeeded: \(succeed.result)")
            let userJoinResult = succeed.result.userJoinResult

            Log.d("user_id: \(userJoinResult.id), access_token: \(userJoinResult.accessToken), refresh_token: \(userJoinResult.refreshToken)")
            
            LoginDataStore.shared.userId = userJoinResult.id
            LoginDataStore.shared.accessToken = userJoinResult.accessToken
            LoginDataStore.shared.refreshToken = userJoinResult.refreshToken
        }
    }
}

extension SignupStepCompleteView: SignupStepViewRepresentable {
    func setup(with viewModel: SignupStepViewModelRepresentable) {
        self.viewModel = viewModel
        //===나중에 바꿔야 함
        SignDataStore.shared.formattedBirthdate = "2000-01-01"
        self.signup()
        //======
        self.viewModel?.isNextButtonEnabled = true
        self.viewModel?.nextButtonAction = {
            NotificationCenter.default.post(name: .userDidLogin, object: nil)
        }
    }
}
