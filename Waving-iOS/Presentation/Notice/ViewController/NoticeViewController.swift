//
//  NoticeViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/17.
//

import UIKit

final class NoticeViewController: UIViewController, SnapKitInterface {
    
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
    private var cellModels: [NoticeCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addComponents()
        setConstraints()
    }
    
    private func setup() {
        cellModels = [.init(type: .anniversary, title: "연락알림", description: "이가영님과의 연락 주기입니다.")]
        
        tableView.separatorStyle = .none
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
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

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < cellModels.count else { return UITableViewCell() }
        
        let cellModel = cellModels[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as? NoticeTableViewCell {
            cell.setup(with: cellModel)
            return cell
        }
        fatalError("NoticeTableViewCell is not dequeueable")
    }
}

extension NoticeViewController: UITableViewDelegate {
    
}
