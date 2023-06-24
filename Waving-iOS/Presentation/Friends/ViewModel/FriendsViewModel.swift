//
//  FriendsViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/24.
//

import Foundation
import Combine
import UIKit

enum FriendType: Int {
    case intro
    case list
    
    func view() -> FriendViewRepresentable? {
        switch self {
        case .intro:
            return FriendsIntroView()
        case .list:
            return FriendsIntroView()
        default:
            return nil
        }
    }
}

protocol FriendViewRepresentable where Self: UIView {
    func setup(with viewModel: FriendsViewModelRepresentable)
}

protocol FriendsViewModelRepresentable {
    func addFriends()
    func didTapBackButton()
}

class FriendsViewModel: FriendsViewModelRepresentable {
    let type: FriendType
    
    init(type: FriendType) {
        self.type = type
    }
    
    func addFriends() {
        Log.d("친구 추가")
    }
    
    func didTapBackButton() {
        Log.d("뒤로 가기")
    }
    
    func didTapForwardButton() {
        Log.d("플러스 버튼")
    }

}
