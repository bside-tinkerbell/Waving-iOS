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
    func friendsAdd()
}

class FriendsViewModel: FriendsViewModelRepresentable {
    let type: FriendType
    
    init(type: FriendType) {
        self.type = type
        
    }
    
    func friendsAdd() {
        Log.d("친구 추가")
    }
}
