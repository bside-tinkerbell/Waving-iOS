//
//  ContactListView.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/07.
//

import UIKit

class ContactListView: UIView, SnapKitInterface {

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
        addSubview(friendscontactCollectionView)
    }
    
    func setConstraints() {
        friendscontactCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension ContactListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsContactCollectionViewCell.identifier, for: indexPath) as? FriendsContactCollectionViewCell else { fatalError() }
        cell.configUI(.none)
        return cell
    }
}

extension ContactListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // self.viewModel?.didTapProfile()
    }
}


extension ContactListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/5.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

