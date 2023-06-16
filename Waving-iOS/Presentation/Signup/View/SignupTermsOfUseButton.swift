//
//  SignupTermsOfUseButton.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/16.
//

import UIKit
import Combine

final class SignupTermsOfUseButton: UIControl {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel().then {
            $0.font = .p_R(16)
            $0.textColor = .gray070
            $0.numberOfLines = 1
        }
        return titleLabel
    }()
    
    private let checkButtonView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
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
            checkButtonView.backgroundColor = .blue
        } else {
            checkButtonView.backgroundColor = .gray
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        updateViewFromState()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
        self.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        updateViewFromState()
    }
    
    /// 초기화 될 때 뷰를 세팅하는 메소드
    private func setupView() {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(titleLabel)
        
        checkButtonView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        stackView.addArrangedSubview(checkButtonView)

    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        checkButtonView.layer.cornerRadius = checkButtonView.frame.height / 2.0
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        isSelected = !isSelected
    }
     
}
