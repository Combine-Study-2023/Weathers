//
//  TodayWeatherData.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import Foundation

struct TodayWeatherData {
    let time: String
    let weatherImage: String
    let hourlyWeather: String
    
    init(time: String, weatherImage: String, hourlyWeather: String) {
        self.time = time
        self.weatherImage = weatherImage
        self.hourlyWeather = hourlyWeather
    }
}

private let weatherImages: [String] = ["status-blur", "status-drizzle", "status-rain", "status-thunder", "status-shower"]

var todayWeatherData: [TodayWeatherData] = [.init(time: "Now",
                                                  weatherImage: weatherImages[0],
                                                  hourlyWeather: "21°"),
                                            .init(time: "10시",
                                                  weatherImage: weatherImages[1],
                                                  hourlyWeather: "21°"),
                                            .init(time: "11시",
                                                  weatherImage: weatherImages[2],
                                                  hourlyWeather: "19°"),
                                            .init(time: "12시",
                                                  weatherImage: weatherImages[3],
                                                  hourlyWeather: "19°"),
                                            .init(time: "1시",
                                                  weatherImage: weatherImages[4],
                                                  hourlyWeather: "19°"),
                                            .init(time: "2시",
                                                  weatherImage: weatherImages[4],
                                                  hourlyWeather: "20°"),
                                            .init(time: "3시",
                                                  weatherImage: weatherImages[4],
                                                  hourlyWeather: "20°"),
                                            .init(time: "4시",
                                                  weatherImage: weatherImages[3],
                                                  hourlyWeather: "18°"),
                                            .init(time: "5시",
                                                  weatherImage: weatherImages[2],
                                                  hourlyWeather: "18°"),
                                            .init(time: "6시",
                                                  weatherImage: weatherImages[0],
                                                  hourlyWeather: "19°")]
