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
    
    private lazy var friendscontactCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(FriendsContactCollectionViewCell.self, forCellWithReuseIdentifier: FriendsContactCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    let friendSelectionButton = WVButton()
    private lazy var friendSelectionButtonViewModel = WVButtonModel(title: "총 0 명 선택", titleColor: .Text.white, backgroundColor: .Button.blackBackground) { [weak self] in
        self?.viewModel.selectFriends()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        setConstraints()
        binding()
    }

    func addComponents() {
        view.backgroundColor = .systemBackground
        [navigationView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(containerView)
        [menuContactLabel, menuSelectLabel].forEach { menuStackView.addArrangedSubview($0)}
        [menuStackView, friendscontactCollectionView, friendSelectionButton].forEach { containerView.addSubview($0) }
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
        
        friendscontactCollectionView.snp.makeConstraints {
            $0.top.equalTo(menuStackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(containerView)
        }
        
        friendSelectionButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: Constants.Intro.loginButtonWidth, height: Constants.Intro.loginButtonHeight))
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        friendSelectionButton.setup(model: friendSelectionButtonViewModel)
        view.bringSubviewToFront(friendSelectionButton)
    }
    
    func binding() {
        
    }
}

extension FriendsContactViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsContactCollectionViewCell.identifier, for: indexPath) as? FriendsContactCollectionViewCell else { fatalError() }
        cell.configUI(.checkBox)
        return cell
    }
}

extension FriendsContactViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/5.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
