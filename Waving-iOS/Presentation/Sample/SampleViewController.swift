//
//  SampleViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/09.
//

import UIKit
import SwiftUI

final class SampleViewController: UIViewController {

    private var viewModel: SampleViewModel?
    
//
//    init(viewModel: SampleViewModel = SampleViewModel()) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
       // print(viewModel?.$sampleData)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.fetchSample()
    }
    
    
}
