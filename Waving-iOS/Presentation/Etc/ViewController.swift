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
    
    let navigationView = NavigationView(frame: .zero, type: .button_twoicon).then {
        $0.titleLabel.text = "프로필"
        $0.favoriteButton.setImage(UIImage(named: "icn_favorites_on"), for:.normal)
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인 버튼", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       // navigationView.backgroundColor = .systemRed
        self.navigationController?.navigationBar.isHidden = true
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        [navigationView, loginButton].forEach { view.addSubview($0) }
    
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(50)
        }

        loginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

