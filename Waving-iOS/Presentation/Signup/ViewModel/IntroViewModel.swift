//
//  IntroViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import Foundation
import Combine

enum IntroRoute {
    case signupView
    case loginView
    case mainTabView
}

final class IntroViewModel {
    
    var route: AnyPublisher<IntroRoute, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<IntroRoute, Never> = .init()
    
    func signup() {
        Log.d("가입")
        sendRoute.send(.signupView)
    }
    
    func login() {
        Log.d("로그인")
        sendRoute.send(.loginView)
    }
    
    func tour() {
        Log.d("둘러보기")
        sendRoute.send(.mainTabView)
    }
}
