//
//  GreetingSuggestionCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/16.
//

import UIKit
import Combine

final class GreetingSuggestionCollectionViewCell: UICollectionViewCell, SnapKitInterface {
    
    private var cancellables: [AnyCancellable] = []
    
    private var viewModel: GreetingSuggestionCellModel?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 12)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 8
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var buttonContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_copy"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupEvent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupEvent()
    }
    
    private func setupView() {
        addComponents()
        setConstraints()
    }
    
    private func setupEvent() {
        copyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCopyButton(_:))))
    }
    
    @objc
    private func didTapCopyButton(_ sender: UITapGestureRecognizer) {
        viewModel?.didTapCopyButton.send()
    }
    
    func addComponents() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        [titleLabel, buttonContainerView].forEach { stackView.addArrangedSubview($0) }
        buttonContainerView.addSubview(copyButton)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-20)
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
        copyButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public func setup(with viewModel: GreetingSuggestionCellModel) {
        self.viewModel = viewModel
        
        viewModel.$titleAttributedText
            .sink { [weak self] in
                self?.titleLabel.attributedText = $0
            }
            .store(in: &cancellables)
    }
}
