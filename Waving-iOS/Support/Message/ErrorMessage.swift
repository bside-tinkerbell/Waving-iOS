//
//  ErrorMessage.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/19.
//

import Foundation

enum ErrorMessageCase: String {
    case passwordCombination = "영문/숫자/특수문자 2가지 이상 조합하세요.(8~20자)"
    case passwordCheck = "비밀번호가 일치하지 않습니다."
    case nameCheck = "2~8자 사이로 입력하세요."
    case authenticationCheck = "인증번호가 일치하지 않습니다."
    case newpasswordCheck = "동일한 비밀번호를 입력해 주세요."
}
