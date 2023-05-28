//
//  MainTabBarViewModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit
import Combine

final class MainTabBarControllerViewModel {
    
    @Published var viewControllers: [UIViewController]?
    
    @Published var selectedIndex: Int?
    
    private let indexManager = MainTabBarIndexManager()
    
    init() {
        viewControllers = makeViewControllers()
        selectedIndex = 0
    }
    
    private func makeViewControllers() -> [UIViewController] {
        
        func navigationController(with rootViewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: UIImage(systemName: selectedImageName))
            return navigationController
        }
        
        return indexManager.menus.compactMap {
            switch $0 {
            case .home:
                return navigationController(with: HomeViewController(), title: "Home", imageName: "house", selectedImageName: "house.fill")
            case .friends:
                return navigationController(with: FriendsViewController(), title: "Friends", imageName: "person.2", selectedImageName: "person.2.fill")
            case .setting:
                return navigationController(with: SettingViewController(), title: "Setting", imageName: "gearshape", selectedImageName: "gearshape.fill")
            }
        }
    }

}

struct MainTabBarIndexManager {
    
    let menus: [TabBarMenu] = [.home, .friends, .setting]
    
    func menu(with index: Int) -> TabBarMenu {
        guard index < menus.count else { return .home }
        return menus[index]
    }
    
    func index(with menu: TabBarMenu) -> Int {
        return menus.firstIndex(of: menu) ?? 0
    }
}

enum TabBarMenu: RawRepresentable {
    typealias RawValue = Int
    case home, friends, setting
    
    var rawValue: RawValue {
        switch self {
        case .home:
            return 0
        case .friends:
            return 1
        case .setting:
            return 2
        }
    }
    
    init(rawValue: RawValue) {
        switch rawValue {
        case 0:
            self = .home
        case 1:
            self = .friends
        case 2:
            self = .setting
        default:
            self = .home
        }
    }
}
