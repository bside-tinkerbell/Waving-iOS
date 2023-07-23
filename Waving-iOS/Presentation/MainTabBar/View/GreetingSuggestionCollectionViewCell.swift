//
//  GreetingSuggestionCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/16.
//

import UIKit

final class GreetingSuggestionCollectionViewCell: UICollectionViewCell, SnapKitInterface {
    
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
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
       UILabel()
    }()
    
    private lazy var buttonContainerView: UIView = {
       UIView()
    }()
    
    private lazy var copyButton: UIButton = {
       UIButton()
    }()
    
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
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-28)
        }
    }
}
