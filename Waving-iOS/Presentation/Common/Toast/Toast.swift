//
//  Toast.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/30.
//

import Foundation
import UIKit

internal enum ToastMessage: String {
    case networkError = "네트워크 연결이 끊겼거나 통신 오류가 발생했습니다"
    case signInMessage = "로그인 후 이용해 주세요"
}

final class Toast: UIView, SnapKitInterface {
        
    //MARK: - components
    private lazy var toastLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        //label.text = "네트워크 연결이 끊겼거나 통신 오류가 발생했습니다"
        label.font = .p_R(16)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.layer.cornerRadius = 10
        label.clipsToBounds  =  true
        return label
    }()
    
    private var toastModel: ToastModel?
    
    //MARK: - Initializer
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
        addSubview(toastLabel)
    }
    
    func setConstraints() {
        toastLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func actions() {
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {self.toastLabel.alpha = 0.0}) { _ in
            self.removeFromSuperview()
        }
    }
    
    public func setupView(model: ToastModel){
        self.toastModel = model
        self.toastLabel.text = toastModel?.title
    }
}

final class ToastModel {
    var title: String
        
    public init(title: String = "네트워크 연결이 끊겼거나 통신 오류가 발생했습니다"){
        self.title = title
    }
}
