//
//  HomeViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit

final class HomeViewController: UIViewController, SnapKitInterface {
    
    private lazy var navigationViewModel: NavigationModel = .init(forwaredButtonImage: UIImage(named: "icn_plus"), title: "나의 지인", didTouchForwared: {[weak self] in
//        self?.viewModel.didTapForwardButton()
    })
    
    private lazy var navigationView: HomeNavigationView = {
        HomeNavigationView()
    }()
    
    let scrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var introView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = NSMutableAttributedString(string: "지금 생각나는 친구에게\n인사를 건네보세요.")
            .wv_setFont(.p_M(20))
            .wv_setTextColor(.gray090)
        
        let imageView = UIImageView()
        // TODO: img 01-03 중에 랜덤으로 나오도록 수정
        imageView.image = UIImage(named: "img_main_02")
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(25)
            $0.trailing.equalTo(imageView.snp.leading).offset(-17)
        }
        
        return view
    }()
    
    private lazy var suggestionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.itemSize = .init(width: 100, height: 110)
        flowLayout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 26
        flowLayout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .zero
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        
        setupView()
        addComponents()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .Main.main050
        suggestionView.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        suggestionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        suggestionView.layer.cornerRadius = 30
        
        collectionView.register(GreetingCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "GreetingCategoryCollectionViewCell")
    }
    
    func addComponents() {
        [navigationView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(containerView)
        [introView, suggestionView, collectionView].forEach { containerView.addSubview($0) }
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constants.Navi.defaultHeight)
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
        
        introView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(131)
        }
        
        suggestionView.snp.makeConstraints {
            $0.top.equalTo(introView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(186)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(suggestionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // test code
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreetingCategoryCollectionViewCell", for: indexPath) as! GreetingCategoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 110)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}
