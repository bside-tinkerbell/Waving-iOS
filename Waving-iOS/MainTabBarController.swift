//
//  MainTabBarController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit
import Combine

class MainTabBarController: UITabBarController {
    
    private var subscriptions = Set<AnyCancellable>()
    
    public lazy var viewModel: MainTabBarControllerViewModel = {
        let viewModel = MainTabBarControllerViewModel()
        // TODO: 뷰모델 세팅 코드 추가
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        setupTabBar()
    }
    
    private func setupTabBar() {
        UITabBar.appearance().backgroundColor = .lightGray
        tabBar.backgroundImage = UIImage()
         
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .white
    }
    
    private func bind() {
        viewModel
            .$viewControllers
            .compactMap { $0 }
            .sink { [weak self] in
                self?.viewControllers = $0
                print("vcs: \($0)")
            }
            .store(in: &self.subscriptions)
        
        viewModel
            .$selectedIndex
            .compactMap { $0 }
            .sink { [weak self] in self?.selectedIndex = $0 }
            .store(in: &self.subscriptions)
    }

}
