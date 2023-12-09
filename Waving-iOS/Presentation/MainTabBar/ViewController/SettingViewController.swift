//
//  SettingViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/05/28.
//

import UIKit

final class SettingViewController: UIViewController, SnapKitInterface {
    
    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    private let viewModel = SettingViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var navigationViewModel: NavigationModel = .init(title: "마이페이지")
    
    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.setup(model: navigationViewModel)
        return view
    }()
    
    private var appearance = UICollectionLayoutListConfiguration.Appearance.plain
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addComponents()
        setConstraints()
        configureDataSource()
    }
    
    private func setupView() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }
    
    func addComponents() {
        [navigationView, collectionView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constants.Navi.defaultHeight)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension SettingViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: self.appearance)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension SettingViewController {
    private func configureDataSource() {
        
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        
        let logout = Item(title: "로그아웃")
        let delete = Item(title: "회원탈퇴")
        snapshot.appendItems([logout, delete])
        dataSource.apply(snapshot)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d("didSelectItemAt: \(indexPath.row)")
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
            // 로그아웃
            viewModel.logout()
        } else if indexPath.row == 1 {
            // 회원탈퇴
            
            let okActionTuple = UIAlertActionTuple(title: AlertData.oKTitle, handler: { [weak self] _ in
                guard let self else { return }
                viewModel.deleteAccount()
            })
            let cancelActionTuple = UIAlertActionTuple(title: AlertData.cancelTitle, handler: nil)
            
            let alertData = AlertData(on: self, title: "탈퇴하시겠습니까?", defaultActionTuples: [okActionTuple], cancelActionTuple: cancelActionTuple)
            UIAlertController.wv_presentAlert(with: alertData)
            
        }
    }
}

final class SettingViewModel {
    func logout() {
        SignAPI.logout { succeed, failed in
            if failed != nil {
                Log.d("logout failed: \(String(describing: failed))")
                return
            }
            
            Log.d("logout succeeded: \(String(describing: succeed))")
            
            NotificationCenter.default.post(name: .userDidLogout, object: nil)
        }
    }
    
    func deleteAccount() {
        guard let userId = LoginDataStore.shared.userId else { return }
        SignAPI.delete(userId: userId) { succeed, failed in
            if failed != nil {
                Log.d("delete failed: \(String(describing: failed))")
                return
            }
            
            Log.d("delete succeeded: \(String(describing: succeed))")
            
            NotificationCenter.default.post(name: .userDidLogout, object: nil)
        }
    }
}
