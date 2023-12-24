//
//  FriendProfileViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/07.
//

import UIKit

final class FriendProfileViewModel {
    func call() {
        guard let phoneNumber = GetFriendsProfileEntity.shared.cellPhone else { return }
        if let url = NSURL(string: "tel://" + phoneNumber),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
