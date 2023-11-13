//
//  Weather.swift
//  Weather-Combine
//
//  Created by sejin on 2023/11/14.
//

import Foundation

struct Weather {
    let title: String
    let description: String
    let temp: Double
}

extension WeatherDto {
    func toModel() -> Weather {
        return Weather(title: self.weather[0].main, description: self.weather[0].description, temp: self.main.temp)
    }
}
