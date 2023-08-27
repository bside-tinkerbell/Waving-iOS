//
//  PasteboardManager.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/08/27.
//

import UIKit

final class ClipboardManager {
    static func save(_ string: String) {
        UIPasteboard.general.string = string
        Log.d("string copied in clipboard")
        // TODO: 클립보드에 복사되었다는 내용으로 toast 띄우기
    }
}
