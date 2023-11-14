//
//  MainWeatherViewModel.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import Foundation
import Combine

class WeatherViewModel {
    
    @Published var forecastInfo: [OpenWeatherData?] = []
    @Published var loading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeatherData() {
        let cities = ["Seoul", "Busan", "Daejeon", "Sokcho", "Jeju"]
        
        Publishers.MergeMany(cities.map { city in
            GetInfoWeatherService.shared.GetRegisterDataWithCombine(cityName: city)
        })
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { complection in
            switch complection {
            case .finished:
                break
            case .failure(let error):
                print("에러:", error)
            }
        }, receiveValue: { [weak self] data in
            print(data)
            self?.forecastInfo.append(data)
        })
        .store(in: &cancellables)
    }
}
