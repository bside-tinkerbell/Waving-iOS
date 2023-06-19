//
//  SignupTermsOfUseButton.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/16.
//

import UIKit
import Combine

final class SignupTermsOfUseButton: UIControl, SnapKitInterface {
    
    private var model: SignupTermsOfUseButtonModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.isUserInteractionEnabled = false
        return horizontalStackView
    }()
    
    private lazy var labelContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel().then {
            $0.font = .p_R(16)
            $0.textColor = .gray070
            $0.numberOfLines = 1
        }
        return titleLabel
    }()
    
    private lazy var checkButtonImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray090
        return view
    }()
    
     public var selectedColor: UIColor = .red {
         didSet {
             updateViewFromState()
         }
     }
     
     override public var isEnabled: Bool {
         didSet {
             updateViewFromState()
         }
     }
     
     override public var isSelected: Bool {
         didSet {
             updateViewFromState()
         }
     }
    
    private func updateViewFromState() {
        if state.contains(.selected) {
            checkButtonImageView.image = .init(named: "icn_correct_selected")
        } else {
            checkButtonImageView.image = .init(named: "icn_correct")
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addComponents()
        setConstraints()
        addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        updateViewFromState()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addComponents()
        setConstraints()
        addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        updateViewFromState()
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        isSelected = !isSelected
        
        model?.didTouchUpInside?(self)
    }
    
    // MARK: SnapKit
    func addComponents() {
        addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(bottomSeparator)
        
        labelContainerView.addSubview(titleLabel)
        horizontalStackView.addArrangedSubview(labelContainerView)
        horizontalStackView.addArrangedSubview(checkButtonImageView)
    }
     
    func setConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        labelContainerView.snp.makeConstraints {
            $0.height.equalTo(46)
        }
        
        checkButtonImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}

extension SignupTermsOfUseButton {
    
    public func setup(model: SignupTermsOfUseButtonModel) {
        self.model = model
        
        model.$title
            .sink { [weak self] in
                self?.titleLabel.text = $0
            }
            .store(in: &cancellables)
        
        model.$showBottomSeparator
            .sink { [weak self] in
                self?.bottomSeparator.isHidden = !$0
            }
            .store(in: &cancellables)
        
        model.$isSelected
            .sink { [weak self] in
                self?.isSelected = $0
            }
            .store(in: &cancellables)
    }
}

final class SignupTermsOfUseButtonModel {
    @Published public var title: String
    @Published public var showBottomSeparator: Bool
    @Published public var isSelected: Bool = false
    
    public var didTouchUpInside: ((UIView) -> Void)?
    
    public init(title: String, showBottomSeparator: Bool = false, didTouchUpInside: ((UIView) -> Void)? = nil) {
        self.title = title
        self.showBottomSeparator = showBottomSeparator
        self.didTouchUpInside = didTouchUpInside
    }
    
}
