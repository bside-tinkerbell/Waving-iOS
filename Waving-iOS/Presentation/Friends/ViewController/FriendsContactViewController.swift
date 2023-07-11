//
//  FriendsContactViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/10.
//

import UIKit
import Combine

class FriendsContactViewController: UIViewController, SnapKitInterface {
    
    private let viewModel = FriendsContactViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Components
    private lazy var navigationViewModel: NavigationModel = .init(title: "지인 선택하기")
    
    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.setup(model: navigationViewModel)
        return view
    }()
    
    let scrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var menuStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 212
        return stackView
    }()
 
    private let menuContactLabel: UILabel = {
        let label = UILabel()
        label.text = "불러온 연락처"
        label.font = .p_B(16)
        return label
    }()
    
    private let menuSelectLabel: UILabel = {
       let label = UILabel()
        label.text = "전체선택"
        label.font = .p_R(14)
        return label
    }()
    
    private var innerView: UIView? //MARK: CollectionView => 따로 View로 빼도록 하기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        setConstraints()
    }

    func addComponents() {
        view.backgroundColor = .systemBackground
        [navigationView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(containerView)
        containerView.addSubview(menuStackView)
        [menuContactLabel, menuSelectLabel].forEach {
            menuStackView.addArrangedSubview($0)
        }
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
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(containerView)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(24)
        }
    }
}
