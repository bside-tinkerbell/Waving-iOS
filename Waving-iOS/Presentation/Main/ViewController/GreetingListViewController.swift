//
//  GreetingListViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/10.
//

import UIKit

final class GreetingListViewController: UIViewController, SnapKitInterface {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    // MARK: - View Models
    private var cellModels: [GreetingCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addComponents()
        setConstraints()
    }
    
    private func setup() {
        cellModels = [
            GreetingCellModel(title: "안녕하세요 벌써 여름이\n다가오고 있네요. 잘 지내시죠?", categoryId: 1, greetingId: 1),
            GreetingCellModel(title: "살아있는 한 무조건 곤란해.\n곤란하지 않게 사는 방법 따윈 결코 없어. 그리고 곤란한 일은 결국 끝나게 돼 있어 <보노보노>", categoryId: 1, greetingId: 2),
            GreetingCellModel(title: "살다보면 안 좋은 날도 있지. 아무 걱정마. 오늘도 행복한 하루가 되게 해줄게. 약속해. <인사이드 아웃>", categoryId: 1, greetingId: 3)
        ]
        tableView.register(GreetingTableViewCell.self, forCellReuseIdentifier: "GreetingTableViewCell")
    }

    func addComponents() {
        view.addSubview(tableView)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension GreetingListViewController: UITableViewDelegate {
    
}

extension GreetingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < cellModels.count else { return UITableViewCell() }
        
        let cellModel = cellModels[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GreetingTableViewCell", for: indexPath) as? GreetingTableViewCell {
            cell.setup(with: cellModel)
            return cell
        }
        fatalError("GreetingTableViewCell is not dequeueable")
    }
    
    
}

// MARK: - TopTabBarRepresentable
extension GreetingListViewController: TopTabBarRepresentable {
    
    func underlineButtonTopTabBarTitle() -> String {
        "카테고리 1"
    }
    
    func parentViewNavigationTitle() -> String {
        "카테고리 1"
    }
}
