//
//  GreetingTableViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/10.
//

import UIKit
import Combine

final class GreetingTableViewCell: UITableViewCell {
    
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
        containerView.layer.cornerRadius = 8
        return containerView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var quotationMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "quotation_mark")
        return imageView
    }()
    
    private lazy var mainLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var paddingView = UIView()
    
    private lazy var favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_favorites_off"), for: .normal)
        button.setImage(UIImage(named: "icn_favorites_on_yellow"), for: .selected)
        return button
    }()
    
    private lazy var copyButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_copy"), for: .normal)
        return button
    }()
    
    private lazy var shareButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_share"), for: .normal)
        return button
    }()
    
    private var cancellables: [AnyCancellable] = []
    
    private var viewModel: GreetingCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            self.cancellables.removeAll()
            
            viewModel.$greeting
                .sink { [weak self] in
                    self?.mainLabel.attributedText = $0
                }
                .store(in: &self.cancellables)
        }

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupEvent()
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // test code
//        contentView.backgroundColor = .green
//        buttonStackView.backgroundColor = .yellow
        // end of test code
    }
    
    private func setupEvent() {
        copyButton.addTarget(self, action: #selector(copyString), for: .touchUpInside)
    }
    
    public func setup(with viewModel: GreetingCellModel) {
        self.viewModel = viewModel
    }
    
    @objc
    private func copyString() {
        viewModel?.didTapCopyButton.send()
    }
}

extension GreetingTableViewCell: SnapKitInterface {
    func addComponents() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(quotationMarkImageView)
        containerView.addSubview(mainLabel)
        containerView.addSubview(buttonStackView)
        
//        buttonStackView.addArrangedSubview(favoriteButton)
        buttonStackView.addArrangedSubview(paddingView)
        buttonStackView.addArrangedSubview(copyButton)
//        buttonStackView.addArrangedSubview(shareButton)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        quotationMarkImageView.snp.makeConstraints {
            $0.width.height.equalTo(Constants.quotationMarkDimension)
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(quotationMarkImageView.snp.bottom).offset(Constants.topSpaceOverMainLableToImageView)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonDimension)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(mainLabel.snp.bottom).offset(Constants.topSpaceOverButtonStackViewToMainLabel)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.buttonDimension)
        }
        
        copyButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.buttonDimension)
        }
        
        shareButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.buttonDimension)
        }
    }
}
