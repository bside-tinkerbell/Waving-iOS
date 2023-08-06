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
    
    @Published var count: Int = 0
    
    var route: AnyPublisher<ContactType, Never> { self.sendRoute.eraseToAnyPublisher() }
    var sendRoute: PassthroughSubject<ContactType, Never> = .init()
    
    func selectFriends() {
        switch count {
        case ..<1 :
            //TODO: 0명이라면 -> 버튼 비활성화 처리 필요
            return
        case 1:
            sendRoute.send(.person)
            return
        case 1...:
            sendRoute.send(.people)
            return
        default:
            return
        }
    }
    
    func checkboxSelected() {
        Log.d("체크박스 선택됨")
    }
    
    func backButtonClicked() {
        Log.d("뒤로 가기 버튼 선택")
    }
}
