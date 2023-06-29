//
//  Networkable.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Moya

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
            return "bear-access-token-sample" //TODO: 바꾸기
        }

      /// plugin객체를 주입하여 provider 객체 생성
        return MoyaProvider<Target>(plugins: [authPlugin])
    }
}
