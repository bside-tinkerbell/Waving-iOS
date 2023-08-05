//
//  FriendsAPI.swift
//  Waving-iOS
//
//  Created by Joy on 2023/07/24.
//

import Foundation

struct FriendsAPI: Networkable {
    typealias Target =  FriendsTarget
    
    /// - Parameter request: FriendsModel
    /// - Returns: SaveFriendsModel, Fail: Error
    static func saveFriends(request: FriendsModel, completion: @escaping (_ succeed: SaveFriendsModel?, _ failed: Error?) -> Void) {
        makeProvider().request(.saveFriend(request), completion: { result in
            switch ResponseData<SaveFriendsModel>.getModelResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                makeToast()
                return completion(nil, error)
            }
        })
    }
}