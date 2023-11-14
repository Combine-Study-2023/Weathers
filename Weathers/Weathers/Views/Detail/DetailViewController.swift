//
//  DetailViewController.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import UIKit
import Then
import SnapKit

class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var contentView = UIView()
    
    private let locationText = UILabel().then {
        let customFont = UIFont(name: "SFProText-Medium", size: 36.0)
        $0.font = customFont
        $0.text = "의정부시"
        $0.textColor = .white
    }
    
    private let degreeNumber = UILabel().then {
        let customDegreeFont = UIFont(name: "SFProText-Thin", size: 102.0)
        $0.font = customDegreeFont
        $0.text = "21°"
        $0.textColor = .white
    }
    
    private let statusText = UILabel().then {
        let customStatusFont = UIFont(name: "SFProText-Regular", size: 24.0)
        $0.font = customStatusFont
        $0.text = "흐림"
        $0.textColor = .white
    }
    
    private let todayDegreeNumber = UILabel().then {
        let customStatusFont = UIFont(name: "SFProText-Medium", size: 20.0)
        $0.font = customStatusFont
        $0.text = "최고:29° 최저:15°"
        $0.textColor = .white
    }
    
    private let descriptionView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.01)
        $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    private var todayWeatherScriptLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        $0.font = UIFont(name: "SFProText-Regular", size: 18)
        $0.numberOfLines = 0
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    
    private let horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
    }
    
    private let weeklyWeatherView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.03)
        $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    private let calendarIcon = UIImageView().then {
        $0.image = UIImage(systemName: "calendar")
        $0.tintColor = UIColor(white: 1, alpha: 0.3)
    }
    
    private let weeklyWeatherSubTitle = UILabel().then {
        $0.font = UIFont(name: "SFProText-Regular", size: 15)
        $0.text = "10일간의 일기예보"
        $0.textColor = .white.withAlphaComponent(0.3)
    }
    
    private let weeklyWeatherTableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .singleLine
        $0.separatorColor = .white
        $0.isScrollEnabled = false
    }
    
    private let mapiconView = UIButton().then {
        let imageView =  UIImage(named: "icon-map")
        $0.setImage(imageView, for: .normal)
    }
    
    private let listIconView = UIButton().then {
        let imageView =  UIImage(named: "icon-list")
        $0.setImage(imageView, for: .normal)
    }
    
    private let bottomLineView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05)
    }
    
    private let pageIconView = UIImageView().then {
        $0.image = UIImage(named: "pageIcon")
    }
    
    private let bottombgView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.9)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setBackgroundImage()
        setConstraints()
        
        setCollectionViewConfig()
        setCollectionViewLayout()
        
        setTableViewConfig()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapListIcon))
            listIconView.addGestureRecognizer(tapGesture)
    }
    
    func setBackgroundImage() {
        let backgroundImage = UIImageView().then {
            $0.image = UIImage(named: "bg")
            $0.contentMode = .scaleAspectFill
        }
        
        contentView.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setConstraints() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        self.scrollView.backgroundColor = .black
        
        self.view.addSubviews(scrollView,
                              bottombgView,
                              mapiconView,
                              listIconView,
                              bottomLineView,
                              pageIconView)
        
        scrollView.addSubviews(contentView)
        
        contentView.addSubviews(locationText,
                                degreeNumber,
                                statusText,
                                todayDegreeNumber,
                                descriptionView,
                                weeklyWeatherView)
        
        descriptionView.addSubviews(todayWeatherScriptLabel,
                                    lineView,
                                    horizontalCollectionView)
        
        weeklyWeatherView.addSubviews(calendarIcon,
                                      weeklyWeatherSubTitle,
                                      weeklyWeatherTableView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.bottom.equalTo(self.view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
        }
        
        locationText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(78)
        }
        
        degreeNumber.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(locationText.snp.bottom).offset(4)
        }
        
        statusText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(degreeNumber.snp.bottom).offset(4)
        }
        
        todayDegreeNumber.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(statusText.snp.bottom).offset(4)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(todayDegreeNumber.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(212)
        }
        todayWeatherScriptLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.top).inset(10)
            $0.leading.equalTo(descriptionView.snp.leading).inset(15)
            $0.trailing.equalTo(descriptionView.snp.trailing).inset(15)
        }
        lineView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherScriptLabel.snp.bottom).offset(11)
            $0.leading.equalTo(descriptionView.snp.leading).inset(14)
            $0.trailing.equalTo(descriptionView.snp.trailing).inset(0)
            $0.height.equalTo(0.2)
        }
        horizontalCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.bottom.equalTo(descriptionView.snp.bottom)
            $0.leading.equalTo(descriptionView.snp.leading).inset(20)
            $0.trailing.equalTo(descriptionView.snp.trailing).inset(20)
        }
        weeklyWeatherView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(86)
            $0.height.equalTo(675)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        calendarIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(15)
        }
        weeklyWeatherSubTitle.snp.makeConstraints {
            $0.top.equalTo(calendarIcon)
            $0.leading.equalTo(calendarIcon.snp.trailing).offset(6)
        }
        weeklyWeatherTableView.snp.makeConstraints {
            $0.top.equalTo(weeklyWeatherSubTitle.snp.bottom).offset(6)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        mapiconView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.equalToSuperview().inset(10)
        }
        listIconView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.trailing.equalToSuperview().inset(10)
        }
        pageIconView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(listIconView)
            $0.width.equalTo(52)
        }
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalTo(bottombgView.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        bottombgView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(82)
            $0.bottom.equalTo(0)
        }
    }
    
    private func setCollectionViewConfig() {
        self.horizontalCollectionView.register(TodayWeatherCollectionViewCell.self,
                                               forCellWithReuseIdentifier: TodayWeatherCollectionViewCell.identifier)
        self.horizontalCollectionView.delegate = self
        self.horizontalCollectionView.dataSource = self
    }
    
    private func setCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 44 , height: 122)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 22
        flowLayout.minimumInteritemSpacing = 3
        self.horizontalCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    private func setTableViewConfig() {
        self.weeklyWeatherTableView.register(WeeklyWeatherTableViewCell.self,
                                             forCellReuseIdentifier: WeeklyWeatherTableViewCell.identifier)
        self.weeklyWeatherTableView.delegate = self
        self.weeklyWeatherTableView.dataSource = self
    }
    
    @objc func tapListIcon() {
        let listVC = ListViewController()
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegate {}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: TodayWeatherCollectionViewCell.identifier,
                                                            for: indexPath) as? TodayWeatherCollectionViewCell else {return UICollectionViewCell()}
        item.bindData(data: todayWeatherData[indexPath.row])
        return item
    }
}

extension DetailViewController: UITableViewDelegate {}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyWeatherTableViewCell.identifier,
                                                       for: indexPath) as? WeeklyWeatherTableViewCell else {return UITableViewCell()}
        
        cell.bindData(data: weeklyWeatherData[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
}
