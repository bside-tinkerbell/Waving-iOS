//
//  LoginViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/09/15.
//

import Combine
import Foundation

class LoginViewModel {
    
    var route: AnyPublisher<Void, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<Void, Never> = .init()
    
    func login() {
        guard let email = SignDataStore.shared.email,
              let password = SignDataStore.shared.password else { return }
//        sendRoute.send()
        
        let loginRequestModel = LoginRequestModel(email: email, password: password)
        SignAPI.login(model: loginRequestModel) { succeed, failed in
            if failed != nil {
                Log.d("login failed")
                return
            }
            
            guard let succeed else { return }
            let tokenModel = succeed.result
            Log.d("login succeeded: \(succeed.result)")
            Log.d("user_id: \(tokenModel.id),access_token: \(tokenModel.accessToken), refresh_token: \(tokenModel.refreshToken)")
            LoginDataStore.shared.userId = tokenModel.id
            LoginDataStore.shared.accessToken = tokenModel.accessToken
            LoginDataStore.shared.refreshToken = tokenModel.refreshToken
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
