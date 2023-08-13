//
//  SampleRepository.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/11.
//

import Foundation
import Combine

protocol SampleRepositoryInterface {
    func fetchSampleData() -> AnyPublisher<[SampleEntity], Error>
}

class SampleDataRepository: SampleRepositoryInterface {
    
    private let dataSource: SampleDataSourceInterface
    
    public init(dataSource: SampleDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    func fetchSampleData() -> AnyPublisher<[SampleEntity], Error> {
        return dataSource.getUsers()
            .map { sampleResponseDTO in
                var sampleEntities = [SampleEntity]()
                for data in sampleResponseDTO.data { sampleEntities.append(data.toDomain()) }
                return sampleEntities
            }
            .eraseToAnyPublisher()
    }
}
