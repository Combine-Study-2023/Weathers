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
  /// Sequence로 모아서 여러 api를 같이 처리하고 싶을 때 다음과 같이 작업 가능, 일괄 작업을 처리할 때 Sequence 퍼블리셔 유용
  func fetchManyCountryWeather() {
    isLoading = true

    let publishers = ["Seoul", "London", "Tokyo", "Los Angeles", "Berlin"].map(weatherWorker.fetchCurrentWeatherData)
    
    /// 1) 순차
    // Publishers.Sequence(sequence: publishers) // 지정된 요소 시퀀스를 게시하는 퍼블리셔, Output Element의
    //   .flatMap { $0 } // 안쓰면 Failure가 추론이 안 됨
    //   .collect(3)
    //   .receive(on: RunLoop.main)
    //   .sink { [weak self] completion in
    //     self?.isLoading = false
    //   } receiveValue: { [weak self] results in
    //     self?.weathers += results
    //   }
    //   .store(in: &cancellables)
    
    /// 2) 병렬 - 실제 확인 시 병렬로 작업 수행 후 데이터 반환
    Publishers.MergeMany(publishers)
      .collect() // 데이터를 배열로 수집(단일 데이터가 아니라)
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        self?.isLoading = false
      } receiveValue: { [weak self] results in
        self?.weathers = results
      }
      .store(in: &cancellables)
  }
}
