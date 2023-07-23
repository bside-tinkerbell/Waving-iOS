//
//  GreetingCategoryCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/14.
//

import UIKit
import Combine

final class GreetingCategoryCollectionViewCell: UICollectionViewCell, SnapKitInterface {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "img_category_01")
        return imageView
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var cancellables: [AnyCancellable] = []
    
    private var viewModel: GreetingCategoryCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            self.cancellables.removeAll()
            
            viewModel.$title
                .sink { [weak self] in
                    self?.titleLabel.attributedText = NSMutableAttributedString(string: $0)
                        .wv_setFont(.p_M(14))
                        .wv_setTextColor(.gray070)
                        .wv_setParagraphStyle(alignment: .center)
                }
                .store(in: &cancellables)
            
            viewModel.$category
                .sink { [weak self] in
                    var imageName = ""
                    switch $0 {
                    case .type1:
                        imageName = "img_category_01"
                    case .type2:
                        imageName = "img_category_02"
                    case .type3:
                        imageName = "img_category_03"
                    case .type4:
                        imageName = "img_category_04"
                    case .type5:
                        imageName = "img_category_05"
                    case .type6:
                        imageName = "img_category_06"
                    }
                    self?.imageView.image = .init(named: imageName)
                }
                .store(in: &cancellables)
            
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
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.top.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(100)
            $0.bottom.centerX.equalToSuperview()
        }
    }
    
    public func setup(with viewModel: GreetingCategoryCellModel) {
        self.viewModel = viewModel
    }
}
