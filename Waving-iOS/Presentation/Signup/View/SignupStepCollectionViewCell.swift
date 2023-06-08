//
//  SignupStepCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit
import Combine

final class SignupStepCollectionViewCell: UICollectionViewCell {
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var containerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        containerView.addSubview(label)
        return label
    }()
    
    private var cancellables: [AnyCancellable] = []
    
    private var viewModel: SignupStepViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            self.cancellables.removeAll()
            viewModel.$title
                .sink { [weak self] in
                    self?.titleLabel.attributedText = $0
                }
                .store(in: &self.cancellables)
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.contentLayoutGuide)
            make.trailing.equalTo(scrollView.contentLayoutGuide)
            make.top.equalTo(scrollView.contentLayoutGuide)
            make.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priority(.low)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
        }
        
    }
    
    public func setup(with viewModel: SignupStepViewModel) {
        self.viewModel = viewModel
        
        let customView = viewModel.type.view()
        containerView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
