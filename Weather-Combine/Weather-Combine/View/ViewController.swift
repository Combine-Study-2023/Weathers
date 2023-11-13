//
//  ViewController.swift
//  Weather-Combine
//
//  Created by sejin on 2023/11/14.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let fetchButtonTap = PassthroughSubject<Void, Never>()
    
    private var cancelBag = Set<AnyCancellable>()
    
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
        self.setAction()
        self.bindViewModel()
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
    
    private func setAction() {
        self.fetchButton.addTarget(self, action: #selector(fetchButtonDidTap), for: .touchDown)
    }
    
    @objc
    private func fetchButtonDidTap(_ sender: UIButton) {
        fetchButtonTap.send()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: self.fetchButtonTap.eraseToAnyPublisher())
        
        output.sink { weather in
            print(weather)
        }.store(in: &cancelBag)
    }
}

