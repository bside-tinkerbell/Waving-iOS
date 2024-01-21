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
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,20}$").evaluate(with: self)
    }
    
    /// 010-xxx(or xxxx)-xxxx 형식의 폰 번호인지 체크
    var isValidPhoneNumber: Bool {
        NSPredicate(format: "SELF MATCHES %@", #"^010-\d{3,4}-\d{4}$"#).evaluate(with: self)
    }
    
    /// 영문이나 한국어로 두 자 이상인지 체크
    var isValidUsername: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z가-힣]{2,}$").evaluate(with: self)
    }
}
