//
//  GreetingCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/10.
//

import Combine
import Foundation

final class GreetingCellModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var greeting: NSAttributedString
    var didTapCopyButton: PassthroughSubject<Void, Never> = .init()
    
    var categoryId: Int
    
    init(title: String, categoryId: Int) {
        self.greeting = NSMutableAttributedString(string: title)
            .wv_setFont(.p_M(20))
            .wv_setTextColor(.gray090)
        self.categoryId = categoryId
        
        bind()
    }
    
    private func bind() {
        didTapCopyButton
            .sink { [weak self] in
                guard let self else { return }
                ClipboardManager.save(greeting.string)
            }
            .store(in: &cancellables)
    }
}
