//
//  TestModel.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/29.
//

import Foundation
import UIKit

struct TestModel: Codable {
    var page: Int
    var per_page: Int
    var data: [dataModel]?
}

struct dataModel: Codable {
    var id : Int
    var email: String
}
