//
//  SampleViewModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import Foundation
import Combine

final class SampleViewModel {
    
//    private let fetchSampleDataUseCase: FetchSampleDataUseCase
//    private var cancellables = Set<AnyCancellable>()
//
//    @Published public var sampleData: [SampleEntity] = []
//
//    init(fetchSampleDataUseCase: FetchSampleDataUseCase) {
//        self.fetchSampleDataUseCase = fetchSampleDataUseCase
//    }
//
//    public func fetchSample() {
//        fetchSampleDataUseCase.execute()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(_):
//                    self.sampleData = []
//                    Log.d("#2")
//                }
//            } receiveValue: { sampleList in
//                self.sampleData = sampleList
//                Log.d("#3")
//            }
//            .store(in: &cancellables)
//    }
}
