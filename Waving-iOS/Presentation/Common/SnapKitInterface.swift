//
//  SnapKitType.swift
//  Waving-iOS
//
//  Created by Joy on 2023/05/28.
//

// MARK: repository 가 위치해야 함

import Foundation
import UIKit

// 스냅킷 라이브러리를 사용할 때 채택하는 protocol입니다.
protocol SnapKitInterface {
    /// 컴포넌트를 추가합니다.
    func addComponents()
    /// 컴포넌트들의 위치를 정해줍니다. 
    func setConstraints()
}
