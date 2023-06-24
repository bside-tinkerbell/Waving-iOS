//
//  FriendsViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit
import Combine

final class FriendsViewController: UIViewController, SnapKitInterface {

    private let viewModel = FriendsViewModel(type: .intro)
    private var cancellable = Set<AnyCancellable>()
    private var friendsRoute: Int = 0
    
    private lazy var navigationViewModel: NavigationModel = .init(backButtonImage: UIImage(named: "icn_back"), title: "회원가입", didTouchBack: {[weak self] in
        self?.viewModel.didTapBackButton()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
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

        if let customView = viewModel.type.view() {
            self.innerView = customView
            customView.setup(with: viewModel)
            containerView.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    func fetchData(){
        //TODO: API 호출에 따른 Switch 문으로 viewModel의 type 바꾸도록 하기 
    }
}
