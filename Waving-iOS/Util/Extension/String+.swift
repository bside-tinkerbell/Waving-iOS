//
//  String+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/09.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    // 영문/숫자/특수문자 2가지 이상 조합하세요.(8~20자)
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^((?:(?=.*[A-Za-z])(?=.*[$@$!%*?&])|(?:(?=.*[A-Za-z])(?=.*\\d)))|(?:(?=.*[$@$!%*?&])(?=.*\\d))).{8,20}$").evaluate(with: self)
    }
}
