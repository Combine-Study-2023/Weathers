//
//  WeatherStore.swift
//  Weeeather
//
//  Created by taekki on 2023/11/14.
//

import SwiftUI
import Combine

final class WeatherStore: ObservableObject {
  @Published var weatherResponse: WeatherResponse?
  @Published var weathers: [WeatherResponse] = []
  @Published var isLoading: Bool = false
  
  private var cancellables = Set<AnyCancellable>()
  private let weatherWorker: WeatherWorker
  
  init(
    weatherResponse: WeatherResponse? = nil,
    weatherWorker: WeatherWorker = WeatherWorker()
  ) {
    self.weatherResponse = weatherResponse
    self.weatherWorker = weatherWorker
  }
  
  func fetchSpecificCountryWeather(_ country: String) {
    weatherWorker.fetchCurrentWeatherData(country)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        // print(completion)
      } receiveValue: { [weak self] response in
        self?.weatherResponse = response
      }
      .store(in: &cancellables)
  }
  
  /// https://yoswift.dev/combine/parallel-download-using-combine/
  /// Sequence로 모아서 여러 api를 같이 처리하고 싶을 때 다음과 같이 작업 가능
  func fetchManyCountryWeather() {
    isLoading = true
    let publishers = ["Seoul", "London", "Tokyo", "Los Angeles", "Berlin"].map(weatherWorker.fetchCurrentWeatherData)
    
    Publishers.Sequence(sequence: publishers)
      .flatMap { $0 }
      .collect()
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        self?.isLoading = false
      } receiveValue: { [weak self] results in
        self?.weathers = results
      }
      .store(in: &cancellables)
  }
}
