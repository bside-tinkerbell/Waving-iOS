//
//  TabViewCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

final class TabViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var coloredBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameLabelWidth: NSLayoutConstraint!
    private var nameLabelHeight: NSLayoutConstraint!
    
    var style: TabViewStyle.CellStyle = .Legacy(nil)
    
    var viewModel: TabViewCollectionViewCellModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            
            let text = self.style.attributedName(viewModel.name, isSelectedState: viewModel.isSelected, isEnabledState: viewModel.isEnabled)
            
            self.nameLabelWidth.constant = text.size().width.rounded(.up)
            self.nameLabelHeight.constant = self.style.nameLabelHeight
            
            self.nameLabel.attributedText = text
            self.coloredBackgroundView.backgroundColor = self.style.underBarViewStateColor(isSelectedState: viewModel.isSelected, isEnabledState: viewModel.isEnabled)
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initViews()
        self.initDefaultConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initViews()
        self.initDefaultConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.attributedText = nil
    }
    
    // MARK: - Private
    
    private func initViews() {
        
        addComponents()
        setConstraints()
        
        // test code
//        contentView.backgroundColor = .cyan
//        contentView.layer.borderColor = UIColor.red.cgColor
        // end of test code
        
        self.coloredBackgroundView.layer.cornerRadius = 18
        
    }
    
    private func initDefaultConstraints() {
        
        self.nameLabelWidth = self.nameLabel.widthAnchor.constraint(equalToConstant: 0.0)
        self.nameLabelHeight = self.nameLabel.heightAnchor.constraint(equalToConstant: self.style.nameLabelHeight)
        
        NSLayoutConstraint.activate([
            self.nameLabelWidth,
            self.nameLabelHeight,
            
        ])
        
    }
    
}

extension TabViewCollectionViewCell: SnapKitInterface {
    func addComponents() {
        contentView.addSubview(coloredBackgroundView)
        contentView.addSubview(nameLabel)
    }
    
    func setConstraints() {
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        coloredBackgroundView.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerY.equalToSuperview()
        }
    }
}
