//
//  GetInfoConfig.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let APIKey = "APIKey"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}
