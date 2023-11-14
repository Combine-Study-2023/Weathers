//
//  Weather.swift
//  Weathers
//
//  Created by yeonsu on 11/14/23.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let timezone: Int
    let name: String
}

struct Main: Codable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
    
    static var placeholder: Main {
        return Main(temp: nil, temp_min: nil, temp_max: nil)
    }
}
