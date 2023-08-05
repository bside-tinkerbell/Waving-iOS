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
    func checkboxSelected()
    func backButtonClicked()
}


final class FriendsContactViewModel: FriendsContactViewModelRepresentable {
    func selectFriends() {
        Log.d("친구 선택하기")
    }
    
    func checkboxSelected() {
        Log.d("체크박스 선택됨")
    }
    
    func backButtonClicked() {
        Log.d("뒤로 가기 버튼 선택")
    }
}
