//
//  WeatherEntity.swift
//  Weather-Seungchan
//
//  Created by 김승찬 on 2023/11/14.
//

import Combine
import Foundation

public struct WeatherEntity: Codable {
    let weather: [Weather]
    let main: WeatherMain
    let wind: WeatherWind
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WeatherWind: Codable {
    let speed: Double
}


public enum NetworkError: Error {
    case invalidURL
    case requestFailed
}

public protocol WeatherService {
    func getCurrentWeather(for city: String) -> AnyPublisher<WeatherEntity, NetworkError>
}

public final class DefaultWeatherService: WeatherService {

    public func getCurrentWeather(for city: String) -> AnyPublisher<WeatherEntity, NetworkError> {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Config.apiKey)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherEntity.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.requestFailed
            }
            .eraseToAnyPublisher()
    }
}
