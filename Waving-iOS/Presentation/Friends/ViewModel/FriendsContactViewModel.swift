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
    private let useCase: FriendsDataUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(_ useCase: FriendsDataUseCase) {
        self.useCase = useCase
    }
    
    func selectFriends() {
        switch count {
        case ..<1 :
            //TODO: 0명이라면 -> 버튼 비활성화 처리 필요
            return
//        case 1:
//            sendRoute.send(.person)
//            return
        case 1...:
            useCase.saveFriends()
                .sink(receiveCompletion: { completion in
                    if case .failure(let err) = completion {
                        Log.e("Retrieving data failed with error \(err)")
                    }
                }, receiveValue: { data in
                    Log.i("Retrieved data of size \(data), response = \(data)")
    
                })
                .store(in: &cancellables)
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
        sendRoute.send(.people) // 뒤로 가기
    }
}
