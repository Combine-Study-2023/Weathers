//
//  WeatherViewModel.swift
//  Weather-Seungchan
//
//  Created by 김승찬 on 2023/11/14.
//

import Combine
import Foundation

final class WeatherViewModel: ViewModelType {
    
    private var cancelBag = CancelBag()
    private var weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    struct Input {
        let inputTextFieldText: AnyPublisher<String, Never>
    }
    
    struct Output {
        let weatherData = PassthroughSubject<[WeatherModel], Never>()
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.inputTextFieldText
            .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: true)
            .flatMap { city in
                return self.weatherService.getCurrentWeather(for: city)
                    .catch { error in
                        output.weatherData.send([])
                        return Empty<WeatherEntity, Never>().eraseToAnyPublisher()
                    }
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { weatherData in
                let fetchedData = [WeatherModel(name: weatherData.name)]
                output.weatherData.send(fetchedData)
            }
            .store(in: self.cancelBag)
            
        return output
    }
}
