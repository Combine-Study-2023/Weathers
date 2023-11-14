//
//  WeeklyWeatherTableViewCell.swift
//  Weather-App
//
//  Created by yeonsu on 11/9/23.
//

import UIKit
import Then
import SnapKit

class WeeklyWeatherTableViewCell: UITableViewCell {
    
    static let identifier: String = "WeeklyWeatherTableViewCell"
    
    private let weekLabel = UILabel().then {
        $0.font = UIFont(name: "SFProText-Medium", size: 22)
        $0.textColor = .white
    }
    
    private let weatherIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let minTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProText-Medium", size: 22)
        $0.textColor = .white
    }
    
    private let temperatureBarImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let maxTemperatureLabel = UILabel().then {
        $0.font = UIFont(name: "SFProText-Medium", size: 22)
        $0.textColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.contentView.addSubviews(weekLabel,
                                     weatherIcon,
                                     minTemperatureLabel,
                                     temperatureBarImage,
                                     maxTemperatureLabel)
        
        weekLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        weatherIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(weekLabel.snp.trailing).offset(30)
            $0.width.equalTo(32)
            $0.height.equalTo(34)
        }
        minTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(weatherIcon.snp.trailing).offset(15)
        }
        temperatureBarImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(minTemperatureLabel.snp.trailing).offset(6)
            $0.trailing.equalTo(maxTemperatureLabel.snp.leading).offset(-6)
            $0.width.equalTo(108)
        }
        maxTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(temperatureBarImage.snp.trailing).inset(10)
            $0.trailing.equalToSuperview().inset(17)
        }
    }
    
    func bindData(data: WeeklyWeatherData) {
        self.weekLabel.text = data.weekDay
        self.weatherIcon.image = UIImage(named: data.weatherImage)
        self.minTemperatureLabel.text = data.minimumTemperature
        self.temperatureBarImage.image = UIImage(named: data.temperatureBarImage)
        self.maxTemperatureLabel.text = data.maximumTemperature
    }
}
