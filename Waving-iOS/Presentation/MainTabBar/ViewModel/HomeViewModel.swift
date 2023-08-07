//
//  HomeViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/08/06.
//

import Foundation
import Combine

final class HomeViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 화면 갱신
    let refresh = PassthroughSubject<Void, Never>.init()
    
    @Published var randomGreeting: String?
    
    /// initializer
    init() {
        bind()
    }
    
    /// api 조회
    private func fetchData() {
        GreetingAPI.getRandomGreeting { [weak self] succeed, failed in
            if failed != nil {
                Log.d("random greeting fetching failed")
                return
            }
            
            guard let succeed else { return }
            self?.randomGreeting = succeed.result.greeting
        }
    }
    
    private func bind() {
        refresh.sink { [weak self] _ in
            self?.fetchData()
        }
        .store(in: &cancellables)
    }

}
