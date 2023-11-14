//
//  ViewModelType.swift
//  Weather-Seungchan
//
//  Created by 김승찬 on 2023/11/14.
//

import Combine
import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
