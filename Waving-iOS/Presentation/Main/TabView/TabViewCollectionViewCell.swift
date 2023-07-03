//
//  TabViewCollectionViewCell.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

final class TabViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var nameLabel: UILabel!
    private var newCountBackgroundImageView: UIImageView!
    private var newCountLabel: UILabel!
    
    private var newMarkImageView: UIImageView!
    
    private var underBarView: UIView!
    
    private var nameLabelWidth: NSLayoutConstraint!
    private var nameLabelHeight: NSLayoutConstraint!
    private var contentViewLeadingToNameLabelLeading: NSLayoutConstraint!
    private var nameLabelTrailingToContentViewTrailing: NSLayoutConstraint!
    private var nameLabelTrailingToNewMarkImageViewLeading: NSLayoutConstraint!
    private var newMarkImageViewTrailingToContentViewTrailing: NSLayoutConstraint!
    
    var style: TabViewStyle.CellStyle = .Legacy(nil)
    
    var viewModel: TabViewCollectionViewCellModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            
            let text = self.style.attributedName(viewModel.name, isSelectedState: viewModel.isSelected, isEnabledState: viewModel.isEnabled)
            
            self.contentViewLeadingToNameLabelLeading.constant = self.style.nameLabelMinimumLeadingMargin
            self.nameLabelWidth.constant = text.size().width.rounded(.up)
            self.nameLabelHeight.constant = self.style.nameLabelHeight
            self.nameLabelTrailingToContentViewTrailing.constant = self.style.nameLabelMinimumTrailingMargin
            
            self.nameLabel.attributedText = text
            self.newCountLabel.text = viewModel.newCountText
            self.newCountLabel.isHidden = viewModel.isNewCountTextHidden
            self.newMarkImageView.isHidden = viewModel.isNewMarkHidden
            self.underBarView.backgroundColor = self.style.underBarViewStateColor(isSelectedState: viewModel.isSelected, isEnabledState: viewModel.isEnabled)
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initViews()
        
        self.initDefaultConstraints()
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initViews()
        
        self.initDefaultConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.attributedText = nil
        self.newCountLabel.text = nil
        self.newCountLabel.isHidden = true
        self.newMarkImageView.isHidden = true
    }
    
    // MARK: - Private
    
    private func initViews() {
        self.nameLabel = UILabel(frame: .zero)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.nameLabel)
        
        self.newCountLabel = UILabel(frame: .zero)
        self.newCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.newCountLabel)
        
        self.newMarkImageView = UIImageView(image: UIImage(named: "ico_new_sticker.png"))
        self.newMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.newMarkImageView)
        
        self.underBarView = UIView(frame: .zero)
        self.underBarView.translatesAutoresizingMaskIntoConstraints = false
        self.underBarView.layer.cornerRadius = 2
        self.contentView.addSubview(self.underBarView)
        
    }
    
    private func initDefaultConstraints() {
        
        self.contentViewLeadingToNameLabelLeading = self.nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor)
        self.nameLabelWidth = self.nameLabel.widthAnchor.constraint(equalToConstant: 0.0)
        self.nameLabelHeight = self.nameLabel.heightAnchor.constraint(equalToConstant: self.style.nameLabelHeight)
        self.nameLabelTrailingToContentViewTrailing = self.contentView.trailingAnchor.constraint(greaterThanOrEqualTo: self.nameLabel.trailingAnchor)
        
        self.nameLabelTrailingToNewMarkImageViewLeading = self.newMarkImageView.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 2.0)
        self.nameLabelTrailingToNewMarkImageViewLeading.priority = (.required - 1)
        
        self.newMarkImageViewTrailingToContentViewTrailing = self.contentView.trailingAnchor.constraint(greaterThanOrEqualTo: self.newMarkImageView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            self.contentViewLeadingToNameLabelLeading,
            self.nameLabelWidth,
            self.nameLabelHeight,
            self.nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.nameLabelTrailingToContentViewTrailing,
            
            self.newMarkImageView.heightAnchor.constraint(equalToConstant: 14.0),
            self.newMarkImageView.widthAnchor.constraint(equalToConstant: 14.0),
            self.nameLabelTrailingToNewMarkImageViewLeading,
            self.newMarkImageViewTrailingToContentViewTrailing,
            self.nameLabel.bottomAnchor.constraint(equalTo: self.newMarkImageView.bottomAnchor, constant: 10.0),
            
            self.underBarView.heightAnchor.constraint(equalToConstant: 3.0),
            self.contentView.leadingAnchor.constraint(equalTo: self.underBarView.leadingAnchor),
            self.contentView.topAnchor.constraint(lessThanOrEqualTo: self.underBarView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.underBarView.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.underBarView.trailingAnchor)
        ])
        
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.nameLabel.textAlignment = .center
        self.nameLabel.backgroundColor = .clear
        self.nameLabel.numberOfLines = 1

        self.newCountLabel.backgroundColor = .clear
        self.newCountLabel.numberOfLines = 1
        self.newCountLabel.font = .p_B(11)
        self.newCountLabel.textColor = .text030
        self.newCountLabel.textAlignment = .center

        self.underBarView.backgroundColor = .clear
    }
    
}
