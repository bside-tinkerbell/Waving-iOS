//
//  Array+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import Foundation

extension Array {
    
    /// 인덱스의 엘리먼트를 전달받은 엘리먼트로 대체한 어레이를 반환한다.
    ///
    /// - Parameter element: 대체할 엘리먼트
    /// - Parameter index: 대상 엘리먼트의 인덱스
    @discardableResult
    mutating func wv_replaced(with element: Element, at index: Int) -> Self {
        
        guard self.wv_isIndexValid(index) else { return self }
        
        self[index] = element
        
        return self
        
    }
    
    /// 인덱스가 유효한지의 여부를 반환한다.
    /// 인덱스가 어레이의 인덱스 범위에 있는지 확인한다.
    ///
    /// - Parameter index: 인덱스
    /// - Returns: 인덱스가 유효한지의 여부
    func wv_isIndexValid(_ index: Int) -> Bool {
        
        return (0 <= index) && (index < self.count)
        
    }
    
    func wv_element(at index: Int) -> Element? {
        
        guard self.wv_isIndexValid(index) else { return nil }
        
        return self[index]
        
    }
    
    func wv_get(index: Int) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        } else {
            return nil
        }
    }
}
