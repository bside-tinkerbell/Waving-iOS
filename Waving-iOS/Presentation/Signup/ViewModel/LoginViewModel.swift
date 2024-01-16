//
//  LoginViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/09/15.
//

import Combine
import Foundation


class LoginViewModel {
    
    private var cancellables: Set<AnyCancellable> = []
    
    let emailPublisher = PassthroughSubject<String, Never>()
    let passwordPublisher = PassthroughSubject<String, Never>()
    
    var route: AnyPublisher<Void, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<Void, Never> = .init()
    
    init() {
        bind()
    }
    
    private func bind() {
        // Combine debounce and receive on the main thread to store data with a 1-second delay
        emailPublisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                updateEmail(text)
            }
            .store(in: &cancellables)
        
        passwordPublisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                updatePassword(text)
            }
            .store(in: &cancellables)
    }
    
    func login() {
        guard let email = SignDataStore.shared.email,
              let password = SignDataStore.shared.password else { return }
        
        let loginRequestModel = LoginRequestModel(email: email, password: password)
        SignAPI.login(model: loginRequestModel) { succeed, failed in
            if let failed {
                Log.d("login failed: \(failed.localizedDescription)")
                return
            }
            
            guard let succeed else { return }
            let tokenModel = succeed.result.token
            Log.d("login succeeded: \(succeed.result)")
            Log.d("user_id: \(tokenModel.id), access_token: \(tokenModel.accessToken), refresh_token: \(tokenModel.refreshToken)")
            LoginDataStore.shared.userId = tokenModel.id
            LoginDataStore.shared.accessToken = tokenModel.accessToken
            LoginDataStore.shared.refreshToken = tokenModel.refreshToken
            
            NotificationCenter.default.post(name: .userDidLogin, object: nil)
        }
    }
    
    // MARK: - Update SignDataStore
    func updateEmail(_ email: String?) {
        SignDataStore.shared.email = email
    }
    
    func updatePassword(_ password: String?) {
        SignDataStore.shared.password = password
    }
}
