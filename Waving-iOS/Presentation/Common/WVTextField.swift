//
//  WVTextField.swift
//  Waving-iOS
//
//  Created by USER on 2023/06/08.
//

import UIKit

enum SignupTextFieldType {
    case email
    case password
    case passwordConfirm
    case username
    case birthdate
    case phoneNumber
    case authCode
}

final class WVTextField: UITextField {

    var type: SignupTextFieldType?

}
