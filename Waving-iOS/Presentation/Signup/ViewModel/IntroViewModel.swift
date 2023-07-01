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
}

final class IntroViewModel {
    
    var route: AnyPublisher<IntroRoute, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<IntroRoute, Never> = .init()
    
    func signup() {
        Log.d("가입")
        sendRoute.send(.signupView)

        SignAPI.getDataList { succeed, failed in
            if((succeed?.data?.count ?? 0) != 0) {
                guard let item = succeed else { return }
                Log.i(item)
            }
        }
    }
    
    func login() {
        Log.d("로그인")
        sendRoute.send(.loginView)
    }
}
