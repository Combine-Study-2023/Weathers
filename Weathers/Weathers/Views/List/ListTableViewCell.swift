//
//  ListTableViewCell.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import UIKit
import Then
import SnapKit

class ListTableViewCell: UITableViewCell {

    static let identifier: String = "ItemListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let listView = UIImageView().then {
        $0.image = UIImage(named: "bg-list")
    }
    
    private let locationLabel = UILabel().then {
        let customTitleFont = UIFont(name: "SFProText-Bold", size: 24.0)
        $0.font = customTitleFont
        $0.text = "나의 위치"
        $0.textColor = .white
    }
    
    private let myLocationLabel = UILabel().then {
        let customTitleFont = UIFont(name: "SFProText-Medium", size: 17.0)
        $0.font = customTitleFont
        $0.text = "의정부시"
        $0.textColor = .white
    }
    
    private let degreeNumber = UILabel().then {
        let customDegreeFont = UIFont(name: "SFProText-Light", size: 52.0)
        $0.font = customDegreeFont
        $0.text = "21°"
        $0.textColor = .white
    }
    
    private let statusText = UILabel().then {
        let customStatusFont = UIFont(name: "SFProText-Regular", size: 16.0)
        $0.font = customStatusFont
        $0.text = "흐림"
        $0.textColor = .white
    }
    
    private let todayDegreeNumber = UILabel().then {
        let customTodayDegreeFont = UIFont(name: "SFProText-Regular", size: 16.0)
        $0.font = customTodayDegreeFont
        $0.text = "최고:29° 최저:15°"
        $0.textColor = .white
    }
    
    private func setConstraints() {
        
        self.contentView.addSubview(listView)
        self.listView.addSubviews(locationLabel,
                                  myLocationLabel,
                                  degreeNumber,
                                  statusText,
                                  todayDegreeNumber)
        self.contentView.backgroundColor = .black
        
        listView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(117)
        }
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
        }
        myLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(locationLabel.snp.bottom).offset(2)
        }
        degreeNumber.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        statusText.snp.makeConstraints {
            $0.leading.equalTo(myLocationLabel)
            $0.bottom.equalToSuperview().inset(10)
        }
        todayDegreeNumber.snp.makeConstraints {
            $0.trailing.equalTo(degreeNumber)
            $0.bottom.equalTo(statusText)
        }
        
    }

}
