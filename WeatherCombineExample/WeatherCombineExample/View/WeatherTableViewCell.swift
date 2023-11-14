//
//  WeatherTableViewCell.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier: String = "WeatherTableViewCell"

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    private let cellBackgroundView = UIView().then {
        $0.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundImage")!)
        $0.layer.cornerRadius = 16
    }
    
    private let mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
    }

    private lazy var verticalLocationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [myLocationLabel, currentTime])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var horizontalTopStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalLocationStackView, temperatureLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var horizontalBottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherLabel, maxTempLabel, minTempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var myLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 24)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        return label
    }()
    
    private lazy var currentTime: UILabel = {
        let label = UILabel()
        label.font = .medium(size: 17)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .light(size: 52)
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(size: 15)
        label.textColor = .white
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(size: 15)
        label.textColor = .white
        return label
    }()

    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        
        self.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(mainStackView)
        
        [horizontalTopStackView, horizontalBottomStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        cellBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(cellBackgroundView).offset(10)
            $0.bottom.equalTo(cellBackgroundView).inset(10)
            $0.leading.trailing.equalTo(cellBackgroundView).inset(16)
        }
    }
    
    // MARK: - Method
    
    func bindData(weatherData: OpenWeatherData) {
        myLocationLabel.text = weatherData.name
        
        let currentTimeUTC = Date() // 현재 UTC 시간
        let koreanTimeFormatted = currentTimeUTC.toKoreanTimeFormat(timeZone: weatherData.timezone)
        
        currentTime.text = koreanTimeFormatted
        temperatureLabel.text = "\(Int(weatherData.main.temp))°"
        maxTempLabel.text = "최고:\(Int(weatherData.main.tempMax))°"
        minTempLabel.text = "최저:\(Int(weatherData.main.tempMin))°"
        
        weatherData.weather.forEach { data in
            weatherLabel.text = data.main
        }
    }
}
