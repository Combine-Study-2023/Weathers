//
//  ViewController.swift
//  Weather-Combine
//
//  Created by sejin on 2023/11/14.
//

import UIKit

final class ViewController: UIViewController {
    
    private let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("데이터 가져오기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    private func setLayout() {
        [fetchButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fetchButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

