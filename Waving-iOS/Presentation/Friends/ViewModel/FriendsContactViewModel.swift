//
//  FriendsContactViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/11.
//

import Foundation
import Combine

final class FriendsContactViewModel {
    var route: AnyPublisher<IntroRoute, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<IntroRoute, Never> = .init()
}
