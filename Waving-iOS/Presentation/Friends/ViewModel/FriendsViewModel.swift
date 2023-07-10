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
    
    var sendRoute: PassthroughSubject<Void, Never> = .init()
    
    init(type: FriendType) {
        self.type = type
    }
    
    func addFriends() {
        Log.d("친구 추가")
        sendRoute.send()
//        Task.init {
//            await fetchAllContacts()
//        }
        
        @Sendable func fetchAllContacts() async {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey] as [CNKeyDescriptor]
      
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

            do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                    let name = contact.familyName + contact.givenName
                    let phoneNumber = contact.phoneNumbers.filter { $0.label == CNLabelPhoneNumberMobile}.map {$0.value.stringValue}.joined(separator:"")
                    Log.i(name)
                    Log.d(phoneNumber)
                    //TODO: 프로필 이미지 정보 API 보낼 수 있게 String화 하기 (contact.imageData) - decoding?
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

}
