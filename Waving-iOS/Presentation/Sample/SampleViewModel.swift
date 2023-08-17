//
//  SampleViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import Foundation
import Combine

//final class SampleViewModel {
//
//        private let useCase: FetchSampleDataUseCase
//        private var cancellables = Set<AnyCancellable>()
//
//        init(_ useCase: FetchSampleDataUseCase) {
//            self.useCase = useCase
//        }
//
//        public func fetchSample() {
//            useCase.execute()
//                .sink(receiveCompletion: { completion in
//                    if case .failure(let err) = completion {
//                        Log.e("Retrieving data failed with error \(err)")
//                    }
//                }, receiveValue: { data in
//                    Log.i("Retrieved data of size \(data), response = \(data)")
//
//                })
//                .store(in: &cancellables)
//        }
//}

final class SampleViewModel {
    
        private let useCase: FriendsDataUseCase
        private var cancellables = Set<AnyCancellable>()
    
        init(_ useCase: FriendsDataUseCase) {
            self.useCase = useCase
        }
    
        public func fetchSample() {
            useCase.saveFriends()
            //useCase.fetchFriendsEntity()
                .sink(receiveCompletion: { completion in
                    if case .failure(let err) = completion {
                        Log.e("Retrieving data failed with error \(err)")
                    }
                }, receiveValue: { data in
                    Log.i("Retrieved data of size \(data), response = \(data)")
    
                })
                .store(in: &cancellables)
        }
}

