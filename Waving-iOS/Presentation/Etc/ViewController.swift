//
//  ViewController.swift
//  Waving-iOS
//
//  Created by USER on 2023/05/19.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController, SnapKitInterface {
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인 버튼", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        view.addSubview(loginButton)
    }
    
    func setConstraints() {
        loginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

}

