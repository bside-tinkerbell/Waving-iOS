//
//  FriendsListView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/24.
//

import UIKit
import Combine

final class FriendsListView: UIView, SnapKitInterface {
    
    var viewModel: FriendsViewModelRepresentable?
    private var friendsList = [GetFriendsEntity]()
    
    let scrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var suggestionView: UIView? //연락 한 번 해볼까요?
    private var favoriteView: UIView? // 즐겨 찾는 지인
    private var contactListView: UIView? // 나의 지인 목록 - UICollectionView 위치
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "나의 지인 목록"
        label.textColor = .gray090
        label.font = .p_B(16)
        return label
    }()
    
    private lazy var friendscontactCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(FriendsContactCollectionViewCell.self, forCellWithReuseIdentifier: FriendsContactCollectionViewCell.identifier)

        view.dataSource = self
        view.delegate = self
      
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func addComponents() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        [titleLabel, friendscontactCollectionView].forEach { containerView.addSubview($0) }
        
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(scrollView).priority(.low)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        friendscontactCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(containerView).offset(20)
            $0.right.equalTo(containerView).offset(-20)
            $0.bottom.equalTo(containerView)
        }
    }
}

extension FriendsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friendsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsContactCollectionViewCell.identifier, for: indexPath) as? FriendsContactCollectionViewCell else { fatalError() }
        cell.friendsList = friendsList[indexPath.row]
        cell.configUI(.none) 
        return cell
    }
}

extension FriendsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FriendsContactCollectionViewCell else { return }
        self.viewModel?.didTapProfile()
        GetFriendsProfileEntity.shared.name = friendsList[indexPath.row].name
        GetFriendsProfileEntity.shared.contactId = friendsList[indexPath.row].contactId
        GetFriendsProfileEntity.shared.friendProfileId = friendsList[indexPath.row].friendProfileId
        GetFriendsProfileEntity.shared.cellPhone = friendsList[indexPath.row].cellPhone
    }
}

extension FriendsListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/5.9)
    }
}


// MARK: FriendViewRepresentable
extension FriendsListView: FriendViewRepresentable {
    func setup(with viewModel: FriendsViewModelRepresentable, with friendsList: [GetFriendsEntity]) {
        self.viewModel = viewModel
        self.friendsList = friendsList
    }
}


