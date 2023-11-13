//
//  WeatherService.swift
//  Weather-Combine
//
//  Created by sejin on 2023/11/14.
//

import Foundation
import Combine

struct WeatherService {
    func getWeatherData() -> AnyPublisher<Weather, Error> {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("base url error")
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherDto.self, decoder: JSONDecoder())
            .map{ $0.toModel() }
            .eraseToAnyPublisher()
    }
}
