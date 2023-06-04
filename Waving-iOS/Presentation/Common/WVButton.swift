//
//  WVButton.swift
//  Waving-iOS
//
//  Created by Jane on 2023/06/03.
//

import UIKit

/// 앱 내에서 공통으로 사용할 수 있는 버튼
/// Waving 의 약자로 WV 을 썼습니다.
final class WVButton: UIView {
    
    private struct Constants {
        static let alphaForDisabledButton = 0.3
    }
    
    // MARK: - View
    private var button: UIButton!
    
    // MARK: - Model
    private var model: WVButtonModel?
    
    var isEnabled: Bool = false {
        didSet {
            self.button.isEnabled = isEnabled
            self.alpha = isEnabled ? 1 : Constants.alphaForDisabledButton
            self.backgroundColor = isEnabled ? self.model?.backgroundColor : .darkText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        
        self.button = {
            let button = UIButton()
            
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.6
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.touchUpInside), for: .touchUpInside)
            button.addTarget(self, action: #selector(self.touchDown), for: .touchDown)
            
            return button
        }()
        
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc
    private func touchUpInside() {
        self.alpha = 1
        self.model?.didTouchUpInside?()
    }
    
    @objc
    private func touchDown() {
        self.alpha = Constants.alphaForDisabledButton
    }
    
    public func setup(model: WVButtonModel) {
        self.model = model
        
        self.backgroundColor = model.backgroundColor
        
        self.isEnabled = model.isEnabled
        
        self.button.setTitle(model.title, for: .normal)
        self.button.setTitleColor(model.titleColor, for: .normal)
        self.button.titleLabel?.font = model.font
        
        self.layer.cornerRadius = model.cornerRadius
        
        if let borderColor = model.borderColor {
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor.cgColor
        }
        
        self.button.snp.makeConstraints { make in
            make.width.equalTo(model.width)
            make.height.equalTo(model.height)
        }
    }
}

final class WVButtonModel: NSObject {
    var title: String?
    var isEnabled: Bool
    var titleColor: UIColor
    var backgroundColor: UIColor
    var font: UIFont
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var borderColor: UIColor?
    var image: UIImage?
    
    let didTouchUpInside: (() -> Void)?
    
    public init(title: String? = "Done",
                isEnabled: Bool = true,
                titleColor: UIColor = .black,
                backgroundColor: UIColor = .white,
                font: UIFont = .p_R(18),
                width: CGFloat = Constants.Intro.loginButtonWidth,
                height: CGFloat = Constants.Intro.loginButtonHeight,
                cornerRadius: CGFloat = Constants.Intro.loginButtonCornerRadius,
                borderColor: UIColor? = nil,
                image: UIImage? = nil,
                didTouchUpInside: (() -> Void)? = nil) {
        self.title = title
        self.isEnabled = isEnabled
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.image = image
        self.didTouchUpInside = didTouchUpInside
    }
}

