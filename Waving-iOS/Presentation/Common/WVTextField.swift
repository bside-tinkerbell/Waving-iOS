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
    
    var textFieldTitle: String? {
        switch self {
        case .email:
            return "이메일"
        case .password:
            return "비밀번호"
        case .username:
            return "이름"
        case .birthdate:
            return "생년월일"
        case .phoneNumber:
            return "전화번호"
        default:
            return nil
        }
    }
    
    var placeholder: String? {
        switch self {
        case .email:
            return "ex) waving@naver.com"
        case .username:
            return "실명을 입력해주세요.(2~8자)"
        case .birthdate:
            return "YYYY-MM-DD"
        case .authCode:
            return "인증번호 입력해주세요."
        default:
            return nil
        }
    }
}

final class WVTextField: UITextField {

    var type: SignupTextFieldType? {
        didSet {
            if type == .password || type == .passwordConfirm {
                isSecureTextEntry = true
                textContentType = .password
            }
        }
    }

}
