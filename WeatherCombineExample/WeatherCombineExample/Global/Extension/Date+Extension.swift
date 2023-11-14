//
//  Date+Extension.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import Foundation

extension Date {
    func toKoreanTimeFormat(timeZone: Int) -> String {
        let timeZoneOffset = timeZone // 한국 시간대 오프셋 (UTC+9)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)

        return formatter.string(from: self)
    }
}
