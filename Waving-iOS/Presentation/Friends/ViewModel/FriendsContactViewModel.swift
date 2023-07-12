//
//  FriendsContactViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/11.
//

import UIKit
import Combine

protocol FriendContactViewRepresentable where Self: UIView {
    func setup(with viewModel: FriendsContactViewModelRepresentable)
}

protocol FriendsContactViewModelRepresentable {
    func selectFriends()
}


final class FriendsContactViewModel: FriendsContactViewModelRepresentable {
    func selectFriends() {
        Log.d("친구 선택하기")
    }
    
    var route: AnyPublisher<IntroRoute, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<IntroRoute, Never> = .init()
}
