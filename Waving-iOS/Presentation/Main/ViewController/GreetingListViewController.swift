//
//  GreetingListViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/10.
//

import UIKit

final class GreetingListViewController: UIViewController, SnapKitInterface {
    
    let category: GreetingCategory
    
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
    
    // MARK: - Init
    init(category: GreetingCategory) {
        self.category = category
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addComponents()
        setConstraints()
    }
    
    private func setup() {
        // test code
        
        // TODO: 카테고리 별 인사말 목록 api 호출
        
        GreetingAPI.getGreetingList(categoryId: category.greetingCategoryId) { [weak self] succeed, failed in
            if failed != nil {
                Log.d("failed")
                return
            }
            
            guard let succeed, let self else { return }
            
            cellModels = succeed.result.greetingList.compactMap { GreetingCellModel(title: $0.greeting, categoryId: $0.greetingCategoryId) }
            tableView.reloadData()
        }

        // end of test code
        
        tableView.separatorStyle = .none
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
        category.title
    }
    
    func parentViewNavigationTitle() -> String {
        category.title
    }
}
