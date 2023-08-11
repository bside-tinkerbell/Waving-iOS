//
//  FetchSampleDataUseCase.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/11.
//

import Foundation
import Combine

protocol FetchSampleDataUseCaseInterface {
    func execute() -> AnyPublisher<[SampleEntity], Error>
}

final class FetchSampleDataUseCase: FetchSampleDataUseCaseInterface {

    private let repository = SampleDataRepository(dataSource: SampleDataSource())
    
    func execute() -> AnyPublisher<[SampleEntity], Error> {
        return repository.fetchSampleData()
    }
}
