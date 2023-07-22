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
    
    func view() -> FriendViewRepresentable? {
        switch self {
        case .intro: /// 지인 추가 : 소중한 지인을~
            return FriendsIntroView()
        case .disconnect: /// 연락처를 가져올 수 없습니다.
            return FriendsDisconnectView()
        case .list: /// 지인 리스트
            return FriendsListView()
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
    @Published var type: FriendType?
    
    func addFriends() {
        Log.d("친구 추가")
        
        Task.init {
            await fetchAllContacts()
        }
        
        @Sendable func fetchAllContacts() async {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey] as [CNKeyDescriptor]
      
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

            do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                    let name = contact.familyName + contact.givenName 
                    let phoneNumber = contact.phoneNumbers.filter { $0.label == CNLabelPhoneNumberMobile}.map {$0.value.stringValue}.joined(separator:"")
                    type = .list
                    Log.i(name)
                    Log.d(phoneNumber)

                    //TODO: 프로필 이미지 정보 API 보낼 수 있게 String화 하기 (contact.imageData) - decoding?
                    //TODO: MODEL array/dictionary/tuple로 만들어 서버에 보낼 수 있게 준비하기
                })
            } catch {
                type = .disconnect
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
