//
//  FriendsViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/05/28.
//

import UIKit
import Combine

extension FriendType {
    fileprivate var viewController: UIViewController {
        switch self {
        case .intro, .disconnect, .list:
            return UIViewController.init()
        case .addFriend:
            return FriendsContactViewController()
        case .moveToProfile:
            return FriendProfileViewController()
        }
    }
}

final class FriendsViewController: UIViewController, SnapKitInterface {
    
    var viewModel = FriendsViewModel(FriendsDataUseCase())
    var friendsList: [GetFriendsEntity] = []
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var navigationViewModel: NavigationModel = .init(forwaredButtonImage: UIImage(named: ""), title: "나의 지인", didTouchForward: {[weak self] in
        self?.viewModel.didTapForwardButton()
    })
    
    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.setup(model: navigationViewModel)
        
        return view
    }()
    
    let scrollView = UIScrollView()
    
    private lazy var containerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var innerView: FriendViewRepresentable?
    
    override func viewDidLoad() {
        addComponents()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        binding()
    }
    
    deinit {
        innerView?.removeFromSuperview()
    }
    
    func addComponents() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        [navigationView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(containerView)
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(scrollView).priority(.low)
        }
    }
    
    func fetchData() {
        self.viewModel.fetchFriends()
    }
    
    func binding() {
        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                self?.navigationController?.pushViewController(route.viewController, animated: false)
            }
            .store(in: &cancellable)
        
        self.viewModel.$type
            .combineLatest(viewModel.$friendsList)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] friendtype, friendsList in

                if let customView = friendtype?.view() {
                    self?.friendsList = friendsList
                    self?.innerView = customView
                    guard let viewModel = self?.viewModel else {return}
                    guard let friendsList = self?.friendsList else {return}
                    guard let innerView = self?.innerView else {return}
                  
                    innerView.setup(with: viewModel, with: friendsList)
                    self?.containerView.addSubview(innerView)
                    innerView.snp.makeConstraints {
                        $0.top.leading.trailing.bottom.equalToSuperview()
                    }
                }
            }
            .store(in: &cancellable)

    }
}
