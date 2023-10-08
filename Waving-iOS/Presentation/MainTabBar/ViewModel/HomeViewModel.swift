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
    @Published var categories: [GreetingCategory]?
    
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
            
            guard let self, let succeed else { return }
            randomGreeting = succeed.result.greeting
        }
        
        GreetingAPI.getGreetingCategories { [weak self] succeed, failed in
            if let failed {
                Log.d("failed: \(failed)")
                return
            }
            
            guard let self, let succeed else { return }
            
            categories = succeed.result.greetingCategoryList.compactMap { model in
                for each in GreetingCategory.allCases {
                    if model.greetingCategoryId == each.greetingCategoryId {
                        return each
                    }
                }
                return nil
            }
        }
    }
    
    private func bind() {
        refresh.sink { [weak self] _ in
            self?.fetchData()
        }
        .store(in: &cancellables)
    }

}
