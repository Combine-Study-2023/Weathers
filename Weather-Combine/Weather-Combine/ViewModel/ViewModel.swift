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
    
    struct Output {
        var weatherTitle: AnyPublisher<String, Never>
        var weatherDescription: AnyPublisher<String, Never>
        var temperature: AnyPublisher<String, Never>
    }
    
    func transform(input: AnyPublisher<Void, Never>) -> Output {
        let weatherPublisher = input.flatMap { _ in
                return self.service.getWeatherData()
                    .catch { _ in
                        Empty<Weather, Never>()
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .print()
            .share()
            .eraseToAnyPublisher()
        
        let title = weatherPublisher.map(\.title).eraseToAnyPublisher()
        let description = weatherPublisher.map(\.description).eraseToAnyPublisher()
        let temperature = weatherPublisher.map(\.temp).map { String($0) }.eraseToAnyPublisher()
        
        return Output(weatherTitle: title, weatherDescription: description, temperature: temperature)
    }
}
