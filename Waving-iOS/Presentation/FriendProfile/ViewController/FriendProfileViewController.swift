//
//  FriendProfileViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/07.
//

import UIKit
import Combine

final class FriendProfileViewController: UIViewController {
    
    private lazy var navigationViewModel: NavigationModel = .init(backButtonImage: UIImage(named: "icn_back"), favoriteButtonImage: UIImage(named:"icn_favorites_off"), forwaredButtonImage: UIImage(named:"icn_edit"), title: "프로필") {[weak self] in
        Log.d("뒤로 가기")
    } didTouchFavorite: { [weak self] in
        Log.d("즐겨찾기")
    } didTouchForwared: { [weak self] in
        Log.d("편집")
    }

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.setup(model: navigationViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray020
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        [navigationView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(containerView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        let containerViewHeight = containerView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        containerViewHeight.priority = .defaultLow
        containerViewHeight.isActive = true
    }
}
