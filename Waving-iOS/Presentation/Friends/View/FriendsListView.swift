//
//  FriendsListView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/24.
//

import UIKit
import Combine

class FriendsListView: UIView, SnapKitInterface {
    
    var viewModel: FriendsViewModelRepresentable?
    
    let scrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        containerView.addSubview(friendscontactCollectionView)
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
        
        friendscontactCollectionView.snp.makeConstraints {
            $0.top.equalTo(containerView)
            $0.leading.equalTo(containerView).offset(20)
            $0.trailing.equalTo(containerView).offset(-20)
            $0.bottom.equalTo(containerView)
        }
        
    }

}

extension FriendsListView: FriendViewRepresentable {
    func setup(with viewModel: FriendsViewModelRepresentable) {
        self.viewModel = viewModel
    }
}


extension FriendsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsContactCollectionViewCell.identifier, for: indexPath) as? FriendsContactCollectionViewCell else { fatalError() }
        cell.configUI(.checkBoxUnselected)
        return cell
    }
}

extension FriendsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FriendsContactCollectionViewCell else { return }
        cell.configUI(.checkBoxSelected)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FriendsContactCollectionViewCell else { return }
        cell.configUI(.checkBoxUnselected)
    }
}


extension FriendsListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/5.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
