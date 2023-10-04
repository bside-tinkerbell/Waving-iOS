//
//  NavigationView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/19.
//

import UIKit
import SnapKit
import Combine

final class NavigationView: UIView, SnapKitInterface {
    
    // MARK: - View
    private lazy var backButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = .p_R(18)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        return button
    }()


    // MARK: - Model
    private var model: NavigationModel?
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
        actions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        [backButton, titleLabel, favoriteButton, forwardButton].forEach { addSubview($0) }
    }
    
    func setConstraints() {
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.Navi.commonPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        favoriteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(forwardButton.snp.left).offset(-Constants.Navi.itemSpacing)
        }

        forwardButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(Constants.Navi.commonPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    func actions() {
        backButton.addTarget(self, action: #selector(self.touchBack), for: .touchUpInside)
        favoriteButton.addTarget(self, action:#selector(self.touchFavorite), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(self.touchForward), for: .touchUpInside)
    }
    
    // MARK: -Actions
    @objc
    private func touchBack() {
        self.model?.didTouchBack?()
    }
    
    @objc
    private func touchFavorite() {
        self.model?.didTouchFavorite?()
    }
    
    @objc
    private func touchForward() {
        self.model?.didTouchForward?()
    }
}

extension NavigationView {
    public func setup(model: NavigationModel) {
        self.model = model
        
        model.$backButtonImage
            .sink { [weak self] image in
                self?.backButton.setImage(image, for: .normal)
            }
            .store(in: &cancellables)
        
        model.$favoriteButtonImage
            .sink { [weak self] image in
                self?.favoriteButton.setImage(image, for: .normal)
            }
            .store(in: &cancellables)
        
        model.$forwardButtonImage
            .sink { [weak self] image in
                self?.forwardButton.setImage(image, for: .normal)
            }
            .store(in: &cancellables)

        model.$forwardButtonText
            .sink { [weak self] text in
                self?.forwardButton.setTitle(text, for: .normal)
                self?.forwardButton.titleLabel?.font = .p_R(14)
                self?.forwardButton.setTitleColor(.black, for: .normal)                
                if text != "" {
                    self?.forwardButton.snp.remakeConstraints {
                        $0.right.equalToSuperview().inset(Constants.Navi.commonPadding)
                        $0.centerY.equalToSuperview()
                        $0.size.equalTo(CGSize(width: 50, height: 24))
                    }
                }
            }
            .store(in: &cancellables)
        
        model.$title
            .sink { [weak self] in
                self?.titleLabel.text = $0
            }
            .store(in: &cancellables)
    }
}


final class NavigationModel: NSObject {
    
    @Published public var backButtonImage: UIImage?
    @Published public var favoriteButtonImage: UIImage?
    @Published public var forwardButtonImage: UIImage?
    @Published public var forwardButtonText: String?
    @Published public var title: String

    let didTouchBack: (() -> Void)?
    let didTouchFavorite: (() -> Void)?
    let didTouchForward: (() -> Void)?
    
    public init(
        backButtonImage: UIImage? = nil,
        favoriteButtonImage: UIImage? = nil,
        forwaredButtonImage: UIImage? = nil,
        forwaredButtonText: String? = "",
        title: String,
        didTouchBack: (() -> Void)? = nil,
        didTouchFavorite: (() -> Void)? = nil,
        didTouchForward: (() -> Void)? = nil) {
        
        self.backButtonImage = backButtonImage
        self.favoriteButtonImage = favoriteButtonImage
        self.forwardButtonImage = forwaredButtonImage
        self.forwardButtonText = forwaredButtonText
        self.title = title
        self.didTouchBack = didTouchBack
        self.didTouchFavorite = didTouchFavorite
        self.didTouchForward = didTouchForward
    }
}
