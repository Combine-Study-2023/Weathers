//
//  MainViewController.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import UIKit
import Combine
import SnapKit
import Then

class MainViewController: UIViewController {
    
    // MARK: - Property
    
    private let viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var searchResult = [OpenWeatherData?]()
    
    private var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
    }
    
    private lazy var topIconImageView = UIImageView().then {
        $0.image = UIImage(named: "ellipsis.circle")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setLayout()
        setDelegate()
        setTableViewConfig()
        fetchWeatherDataCombine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - layouts
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigationTitle() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "도시 또는 공항 검색"
        
        navigationItem.searchController = searchController
        navigationItem.title = "날씨"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: topIconImageView)
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setTableViewConfig() {
        self.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    // MARK: - methods
    
    func fetchWeatherDataCombine() {
        viewModel.fetchWeatherData()
        
        viewModel.$forecastInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
    }
}

// MARK: - extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.forecastInfo.count)
        return searchController.searchBar.text?.count ?? 0 > 0  ? searchResult.count : viewModel.forecastInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        if searchController.searchBar.text?.isEmpty == false {
            // 검색 상태일 때
            guard let search = searchResult[indexPath.row] else { return UITableViewCell() }
            cell.bindData(weatherData: search)
            
        } else {
            // 일반 상태일 때
            guard let info = viewModel.forecastInfo[indexPath.row] else { return UITableViewCell() }
            cell.bindData(weatherData: info)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        let pageViewController = Week3DetailWeatherViewController()
        //        pageViewController.bindData(forecaseInfo: forecastInfo[indexPath.row], identifier: indexPath.row)
        //
        //        navigationController?.pushViewController(pageViewController, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchWeatherData(searchText: searchController.searchBar.text)
    }
    
    private func searchWeatherData(searchText: String?) {
        
        searchResult = viewModel.forecastInfo.compactMap { $0 }.filter {
            $0.name.contains(searchText ?? "")
        }
        
        tableView.reloadData()
    }
}
