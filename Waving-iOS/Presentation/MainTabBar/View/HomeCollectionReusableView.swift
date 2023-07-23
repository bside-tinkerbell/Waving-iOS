//
//  HomeCollectionReusableView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/23.
//

import UIKit
import Combine

final class HomeCollectionHeaderView: UICollectionReusableView, SnapKitInterface {
    
    private var viewModel: HomeCollectionHeaderViewModel? {
        didSet {
            bind()
        }
    }
    
    private var cancellables = [AnyCancellable]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addComponents()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private
    
    func addComponents() {
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func bind() {
        viewModel?.$title
            .sink { [weak self] in
                self?.titleLabel.attributedText = NSMutableAttributedString(string: $0)
                    .wv_setFont(.p_SB(20))
                    .wv_setTextColor(.gray090)
            }
            .store(in: &cancellables)
    }
    
    func setup(with viewModel: HomeCollectionHeaderViewModel) {
        self.viewModel = viewModel
    }
}
    
