//
//  FriendsViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit
import Contacts

final class FriendsViewController: UIViewController {
    
    private let contactButton: UIButton = {
          let button = UIButton()
          button.setTitle("지인 불러오기", for: .normal)
          button.backgroundColor = .black
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.textAlignment = .center
          return button
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    

    private func setupViews() {
        view.addSubview(contactButton)
        contactButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        contactButton.addTarget(self, action: #selector(didTapContact), for: .touchUpInside)
    }
    
    @objc func didTapContact() {
        Task.init {
            await fetchAllContacts()
        }
        // TODO: API POST로 보내도록 하기
    }
    
    func fetchAllContacts() async {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
  
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                let name = contact.familyName + contact.givenName
                let phoneNumber = contact.phoneNumbers.filter { $0.label == CNLabelPhoneNumberMobile}.map {$0.value.stringValue}.joined(separator:"")
                Log.i(name)
                Log.d(phoneNumber)
            })
        } catch {
            Log.e("연락처를 가져올 수 없습니다 화면으로 이동하기")
        }
    }

}
