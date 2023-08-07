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
    
    var viewModel = FriendsViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var navigationViewModel: NavigationModel = .init(forwaredButtonImage: UIImage(named: "icn_plus"), title: "나의 지인", didTouchForwared: {[weak self] in
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
    
    private var innerView: UIView?
    
    override func viewDidLoad() {
        addComponents()
        setConstraints()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //TODO: 데이터 호출 (fetchData) 후 switch문 통해 바꾸도록 하기
        /// 데이터 있다면 .list 로
        /// 데이터 없다면 .intro가 나오도록 하기
        self.viewModel.type = .list
    }
    
    func addComponents() {
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
    
    func binding() {
        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                let navVC = UINavigationController(rootViewController: route.viewController)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: false)
            }
            .store(in: &cancellable)
        
        self.viewModel.$type
            .receive(on: DispatchQueue.main)
            .sink { [weak self] friendtype in
                if let customView = friendtype?.view() {
                    self?.innerView = customView
                    guard let viewModel = self?.viewModel else {return}
                    customView.setup(with: viewModel)
                    self?.containerView.addSubview(customView)
                    customView.snp.makeConstraints { make in
                        make.top.leading.trailing.bottom.equalToSuperview()
                    }
                }
            }
            .store(in: &cancellable)
    }
}
