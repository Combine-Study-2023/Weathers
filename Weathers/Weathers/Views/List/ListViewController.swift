//
//  ListViewController.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import UIKit
import Then
import SnapKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier,
                                                       for: indexPath) as? ListTableViewCell else {return UITableViewCell()}
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMyLocationView))
        cell.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    private let etcButton = UIButton().then {
        let etcIcon = UIImage(named: "icon-etc")
        $0.setImage(etcIcon, for: .normal)
    }
    
    private let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .init(.black)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews(etcButton,
                              tableView)
        setConstraints()
        setTableViewConfig()
        self.tableView.alwaysBounceVertical = true
    }
    
    private func setTableViewConfig() {
        self.tableView.register(ListTableViewCell.self,
                                forCellReuseIdentifier: ListTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setConstraints() {
        etcButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(etcButton.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    public let searchTextField = UITextField().then {
        let placeholderTextColor = UIColor.lightGray
        $0.borderStyle = .roundedRect
        $0.placeholder = "도시 또는 공항 검색"
        $0.textColor = .white
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: placeholderTextColor
        ]
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: attributes)
        $0.backgroundColor = .secondarySystemFill
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.image = UIImage(named: "icon-search")
        $0.leftView = imageView
        $0.leftViewMode = .always
        
        let marginView = UIView()
        imageView.frame = CGRect(x: 0, y: 0, width: 8, height: 24)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let appTitle = UILabel().then {
            let customFont = UIFont(name: "SFProText-Bold", size: 36.0)
            $0.font = customFont
            $0.text = "날씨"
            $0.textColor = .white
        }
        
        headerView.addSubviews(appTitle, searchTextField)
        appTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(appTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(44)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 108.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    
    @objc func tapMyLocationView() {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
