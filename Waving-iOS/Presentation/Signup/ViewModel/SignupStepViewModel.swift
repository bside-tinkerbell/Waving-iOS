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
    
    fileprivate var textFieldTypes: [SignupTextFieldType] {
        switch self {
        case .emailPassword:
            return [.email, .password, .passwordConfirm]
        case .username:
            return [.username]
        case .birthdate:
            return [.birthdate]
        case .phoneNumber:
            return [.phoneNumber, .authCode]
        default:
            return []
        }
    }
    
    func view() -> SignupStepViewRepresentable {
        switch self {
        case .emailPassword:
            return SignupStepEmailPasswordView()
        default:
            return SignupStepEmailPasswordView()
        }
    }
}

protocol SignupStepViewRepresentable where Self: UIView {
    func setup(with viewModel: SignupStepViewModelRepresentable)
}

protocol SignupStepViewModelRepresentable {
    func updateEmail(_ email: String?)
    func updatePassword(_ password: String?)
    var isNextButtonEnabled: Bool { get set }
}

class SignupStepViewModel: SignupStepViewModelRepresentable {
    let type: SignupStepType
    let textFieldTypes: [SignupTextFieldType]
    @Published var title: NSAttributedString?
    var updateNextButtonEnabled: ((Bool) -> Void)?
    @Published var showPreviousButton = true
    @Published var showNextButton = true
    @Published var isNextButtonEnabled: Bool = false
    
    init(type: SignupStepType) {
        self.type = type
        self.textFieldTypes = type.textFieldTypes
        self.title = NSMutableAttributedString(string: type.title)
            .wv_setFont(.p_M(24))
            .wv_setTextColor(.text090)
        
        if type == .emailPassword {
            showPreviousButton = false
        }
    }
    
    // MARK: - Updating SignDataStore
    func updateEmail(_ email: String?) {
        SignDataStore.shared.email = email
    }
    
    func updatePassword(_ password: String?) {
        SignDataStore.shared.password = password
    }
}

//final class SignupStepEmailPasswordViewModel: SignupStepViewModel {
//    override init(type: SignupStepType) {
//        assert(type == .emailPassword)
//        super.init(type: type)
//    }
//
//    convenience init() {
//        self.init(type: .emailPassword)
//    }
//
//    // MARK: - Updating SignDataStore
//    func updateEmail(_ email: String?) {
//        SignDataStore.shared.email = email
//    }
//
//    func updatePassword(_ password: String?) {
//        SignDataStore.shared.password = password
//    }
//}
