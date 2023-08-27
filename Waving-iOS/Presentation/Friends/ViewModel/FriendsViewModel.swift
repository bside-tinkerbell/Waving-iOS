//
//  FriendsViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/24.
//

import Foundation
import Combine
import UIKit
import Contacts

enum FriendType {
    case intro
    case disconnect
    case list
    case addFriend
    case moveToProfile
    
    func view() -> FriendViewRepresentable? {
        switch self {
        case .intro: /// 지인 추가 : 소중한 지인을~
            return FriendsIntroView()
        case .disconnect: /// 연락처를 가져올 수 없습니다.
            return FriendsDisconnectView()
        case .list: /// 지인 리스트
            return FriendsListView()///지인 추가 화면
        case .addFriend, .moveToProfile: /// 지인 선택하기 화면
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
    func didTapProfile()
}

class FriendsViewModel: FriendsViewModelRepresentable {
    @Published var type: FriendType?
    var route: AnyPublisher<FriendType, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }

    var sendRoute: PassthroughSubject<FriendType, Never> = .init()
    
    func addFriends() {
        Log.d("친구 추가")
        
        Task.init {
            await fetchAllContacts()
             if type == .addFriend {
                 sendRoute.send(.addFriend)
             } else {
                 type = .disconnect
             }
        }
        
        @Sendable func fetchAllContacts() async {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey] as [CNKeyDescriptor]
      
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

            do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                    let name = contact.familyName + contact.givenName 
                    let phoneNumber = contact.phoneNumbers.filter { $0.label == CNLabelPhoneNumberMobile }.map { $0.value.stringValue }.joined(separator:"")
                    type = .addFriend
                    myContactList.append(ContactEntity(name: name, phoneNumber: phoneNumber))
//                    personList.append(PersonModel(name: name, phoneNumber: phoneNumber, contactCycle: 4))
                })
            } catch {
                Log.e("연락처를 가져올 수 없습니다 화면으로 이동하기")
            }
      
        }
        
    }
    
    func didTapBackButton() {
        Log.d("뒤로 가기")
    }
    
    func didTapForwardButton() {
        Log.d("플러스 버튼")
    }
    
    func didTapProfile() {
        sendRoute.send(.moveToProfile)
    }
}
