//
//  Publisher+Bind.swift
//  Weather-Seungchan
//
//  Created by 김승찬 on 2023/11/14.
//

import Foundation
import Combine

public typealias Binding = Subscriber

public extension Publisher where Failure == Never {
    func bind<B: Binding>(subscriber: B) -> AnyCancellable
        where B.Failure == Never, B.Input == Output {
            
            handleEvents(receiveSubscription: { subscription in
                subscriber.receive(subscription: subscription)
            })
                .sink { value in
                    _ = subscriber.receive(value)
            }
    }
}
