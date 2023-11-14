//
//  TodayWeatherCollectionViewCell.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import UIKit
import Then
import SnapKit

class TodayWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TodayWeatherCollectionViewCell"

    private let timeLabel = UILabel().then {
        $0.font = UIFont(name: "SFProText-Medium", size: 17.0)
        $0.textColor = .white
    }
    
    private let weatherIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let degree = UILabel().then {
        $0.font = UIFont(name: "SFProText-Medium", size: 22.0)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.addSubviews(timeLabel, weatherIcon, degree)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(14)
            $0.centerX.equalTo(timeLabel)
        }
        
        degree.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(4)
            $0.centerX.equalTo(timeLabel)
        }

    }
    
    var itemRow: Int?
    
    func bindData(data: TodayWeatherData) {
        self.timeLabel.text = data.time
        self.weatherIcon.image = UIImage(named: data.weatherImage)
        self.degree.text = data.hourlyWeather
    }
    
}
