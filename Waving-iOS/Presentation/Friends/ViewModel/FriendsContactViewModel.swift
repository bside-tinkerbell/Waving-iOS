//
//  FriendsContactViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/11.
//

import UIKit
import Combine

enum ContactType {
    case person
    case people
}

protocol FriendsContactViewModelRepresentable {
    func selectFriends()
    func checkboxSelected()
    func backButtonClicked()
}

final class FriendsContactViewModel: FriendsContactViewModelRepresentable {
    
    var route: AnyPublisher<ContactType, Never> { self.sendRoute.eraseToAnyPublisher() }
    var sendRoute: PassthroughSubject<ContactType, Never> = .init()
    
    func selectFriends() {
        // 숫자에 따라 people인지 person인지 결정됨
        sendRoute.send(.person)
    }
    
    func checkboxSelected() {
        Log.d("체크박스 선택됨")
    }
    
    func backButtonClicked() {
        Log.d("뒤로 가기 버튼 선택")
    }
}
