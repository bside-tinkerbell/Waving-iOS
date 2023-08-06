//
//  NoticeTableViewCell.swift
//  Waving-iOS
//
//  Created by USER on 2023/07/17.
//

import UIKit

final class NoticeTableViewCell: UITableViewCell, SnapKitInterface {
    
    private struct Constants {
        static let quotationMarkDimension: CGFloat = 32
        static let topSpaceOverMainLableToImageView: CGFloat = 16
        static let buttonDimension: CGFloat = 24
        static let topSpaceOverButtonStackViewToMainLabel: CGFloat = 32
    }
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.Border.gray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 4
        return containerView
    }()
    
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "FFFAD9")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "icn_message")
        return imageView
    }()
    
    private lazy var contentsVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var titleHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: NoticeCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        contentView.addSubview(containerView)
        iconContainerView.addSubview(iconImageView)
        
        [iconContainerView, contentsVerticalStackView].forEach { containerView.addSubview($0) }
        [titleLabel, dateLabel].forEach { titleHorizontalStackView.addArrangedSubview($0) }
        [titleHorizontalStackView, descriptionLabel].forEach { contentsVerticalStackView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        
        iconContainerView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.leading.top.equalToSuperview().offset(16)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.center.equalToSuperview()
        }
        
        contentsVerticalStackView.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(6)
            $0.top.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }

    func setup(with viewModel: NoticeCellModel) {
        self.viewModel = viewModel
    }
}
