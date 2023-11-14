//
//  GetInfoWeatherService.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import Foundation
import Combine

final class GetInfoWeatherService {
    
    static let shared = GetInfoWeatherService()
    private init() {}
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    private func makeRequest(cityName: String) -> URLRequest? {
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.APIKey) as? String ?? ""
        
        let urlString = "\(baseURL)?q=\(cityName)&appid=\(apiKey)&units=metric"
        print(urlString)
        guard let url = URL(string: urlString) else {
            print("유효하지않은 URL 입니다.")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
    
    func GetRegisterDataWithCombine(cityName: String) -> AnyPublisher<OpenWeatherData, NetworkError> {
        guard let request = self.makeRequest(cityName: cityName) else {
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: OpenWeatherData.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return .responseDecodingError
                } else {
                    return .unknownError
                }
             }
             .eraseToAnyPublisher()
    }
    
    private func parseOpenWeatherData(data: Data) -> OpenWeatherData? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(OpenWeatherData.self, from: data)
            
            return result
        } catch {
            print(error)
            return nil
        }
    }

    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}
