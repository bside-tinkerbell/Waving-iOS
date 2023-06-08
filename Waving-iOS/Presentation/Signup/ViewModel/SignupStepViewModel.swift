//
//  SignupStepViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit
import Foundation
import Combine

enum SignupStepType: Int {
    case emailPassword
    case username
    case birthdate
    case phoneNumber
    case termsOfUse
    case complete
    
    fileprivate var title: String {
        switch self {
        case .emailPassword:
            return "회원 가입을 위해\n항목을 작성해주세요."
        case .username:
            return "사용하실 이름을\n입력해주세요."
        case .birthdate:
            return "생년월일을\n입력해주세요."
        case .phoneNumber:
            return "전화번호를\n입력해주세요."
        case .termsOfUse:
            return "이용 약관에\n동의해주세요."
        case .complete:
            return "회원가입이 완료 됐습니다\n만나서 반가워요 👋🏻"
        }
    }
    
    fileprivate var previousStep: SignupStepType? {
        switch self {
        case .emailPassword: return nil
        case .username: return .emailPassword
        case .birthdate: return .username
        case .phoneNumber: return .birthdate
        case .termsOfUse: return .phoneNumber
        case .complete: return .termsOfUse
        }
    }
    
    func view() -> UIView {
        switch self {
        case .emailPassword:
            return SignupStepEmailPasswordView()
        default:
            return UIView()
        }
    }
}

final class SignupStepViewModel {
    let type: SignupStepType
    @Published var title: NSAttributedString?
    
    init(type: SignupStepType) {
        self.type = type
        self.title = NSMutableAttributedString(string: type.title)
            .wv_setFont(.p_M(24))
            .wv_setTextColor(.text090)
    }
    
    func updateEmail(_ email: String?) {
        SignDataStore.shared.email = email
    }
    
    
}
