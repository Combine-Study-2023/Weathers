//
//  Constants.swift
//  Weathers
//
//  Created by yeonsu on 11/14/23.
//

import Foundation

struct Constants {
    struct URLs {
        static func weather(city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a4766e8295d121a9d02bf06520ee56b6&units=metric"
        }
        static let weather = "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=a4766e8295d121a9d02bf06520ee56b6&units=metric"
    }
}
