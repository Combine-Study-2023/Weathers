//
//  WeatherResponse.swift
//  Weeeather
//
//  Created by taekki on 2023/11/14.
//

import Foundation

struct WeatherResponse: Identifiable, Decodable {

  struct Location: Decodable {
    let name: String
    let country: String
  }
  
  struct Condition: Decodable {
    let text: String
    let icon: String
    
    var iconString: String {
      "https:" + icon
    }
  }
  
  struct Current: Decodable {
    let tempC: Double
    let condition: Condition
    
    var tempCString: String {
      String(tempC)
    }
    
    enum CodingKeys: String, CodingKey {
      case tempC = "temp_c"
      case condition
    }
  }

  var id: UUID {
    UUID()
  }
  let location: Location
  let current: Current
}
