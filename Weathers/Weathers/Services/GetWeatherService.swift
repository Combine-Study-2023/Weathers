//
//  GetWeatherService.swift
//  Weathers
//
//  Created by yeonsu on 11/14/23.
//

import Foundation
import Combine

class GetWeatherService {
    func fetchWeather(city: String) -> AnyPublisher<WeatherResponse, Error> {
            guard let url = URL(string: Constants.URLs.weather(city: city)) else {
                fatalError("Invalid")
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .catch { error in
                    return Fail(error: error).eraseToAnyPublisher()
                }
                .map { $0.data }
                .decode(type: WeatherResponse.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
}
