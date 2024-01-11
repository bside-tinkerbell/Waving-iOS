//
//  Networkable.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Moya
import Foundation
import UIKit

protocol Networkable {
    /// provider객체 생성 시 Moya에서 제공하는 TargetType을 명시해야 하므로 타입 필요
    associatedtype Target: TargetType
    /// DIP를 위해 protocol에 provider객체를 만드는 함수 정의
    static func makeProvider() -> MoyaProvider<Target>
}

extension Networkable {

    static func makeProvider() -> MoyaProvider<Target> {
        /// access token 세팅
        let authPlugin = AccessTokenPlugin { _ in
            guard let accessToken = LoginDataStore.shared.accessToken else { return "bear-access-token-sample" }
            return accessToken
        }

      /// plugin객체를 주입하여 provider 객체 생성
        return MoyaProvider<Target>(plugins: [authPlugin])
    }
    
    static func makeToast() {
        let toast = Toast()
        lazy var toastModel: ToastModel = .init(title: ToastMessage.networkError.rawValue)
        toast.setupView(model: toastModel)

        if let vc = UIApplication.getMostTopViewController() {
            if let navi = vc.navigationController {
                navi.view.addSubview(toast)
                toast.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
    }
}
