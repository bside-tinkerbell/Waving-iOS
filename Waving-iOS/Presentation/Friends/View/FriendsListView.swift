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
    
    private var suggestionView: UIView? 
    private var favoriteView: UIView?
    private var contactListView: UIView? //UICollectionView 위치
    
    
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
//        containerView.addSubview(friendscontactCollectionView)
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
    }
}

extension FriendsListView: FriendViewRepresentable {
    func setup(with viewModel: FriendsViewModelRepresentable) {
        self.viewModel = viewModel
    }
}


