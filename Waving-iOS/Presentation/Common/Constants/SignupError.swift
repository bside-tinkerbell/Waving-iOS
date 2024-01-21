//
//  SignupError.swift
//  Waving-iOS
//
//  Created by Joy on 1/21/24.
//

import Foundation

enum SignupErrror: String {
    case passwordCombination = "영문/숫자/특수문자 2가지 이상 조합하세요.(8~20자)"
    case passwordCheck = "동일한 비밀번호를 입력해주세요."
    case nameCheck = "2~8자 사이로 입력하세요."
    case authenticationCheck = "인증번호가 일치하지 않습니다."
    case phoneNumCheck = "인증번호 유효시간이 초과되었습니다."
}
