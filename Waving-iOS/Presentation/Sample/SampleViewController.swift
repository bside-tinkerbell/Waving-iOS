//
//  SampleViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import UIKit

final class SampleViewController: UIViewController {
    
    //var viewModel = SampleViewModel(FetchSampleDataUseCase())
    var viewModel = SampleViewModel(FriendsDataUseCase())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        viewModel.fetchSample()
    }
}
