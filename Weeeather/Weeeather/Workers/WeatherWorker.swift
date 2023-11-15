//
//  WeatherWorker.swift
//  Weeeather
//
//  Created by taekki on 2023/11/14.
//

import Foundation
import Combine

final class WeatherWorker {
  func fetchCurrentWeatherData(_ country: String) -> AnyPublisher<WeatherResponse, Error> {
    let apiRequest = APIRequest(
      baseURL: APIEnvironment.baseURL,
      path: "/current.json",
      query: [
        "q": country,
        "aqi": "NO",
        "key": APIEnvironment.Key
      ]
    )
    
    let urlRequest = try! apiRequest.makeURLRequest()
    
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .decode(type: WeatherResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
