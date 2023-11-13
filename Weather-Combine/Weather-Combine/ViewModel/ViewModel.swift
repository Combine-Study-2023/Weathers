//
//  ViewModel.swift
//  Weather-Combine
//
//  Created by sejin on 2023/11/14.
//

import Foundation
import Combine

final class ViewModel {
    private let service = WeatherService()
    
    func transform(input: AnyPublisher<Void, Never>) -> AnyPublisher<Weather, Never> {
        return input.flatMap { _ in
            return self.service.getWeatherData()
                .catch { _ in
                    Empty<Weather, Never>()
                }
                .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
