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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.text = "날씨"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "날씨 정보"
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "기온"
        return label
    }()
    
    private let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("데이터 가져오기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel,
                                                       self.descriptionLabel,
                                                       self.temperatureLabel,
                                                       self.fetchButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.setAction()
        self.bindViewModel()
    }
    
    private func setLayout() {
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
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
        
        output.weatherTitle
            .assign(to: \.text!, on: titleLabel)
            .store(in: &cancelBag)
        
        output.weatherDescription
            .assign(to: \.text!, on: descriptionLabel)
            .store(in: &cancelBag)
        
        output.temperature
            .assign(to: \.text!, on: temperatureLabel)
            .store(in: &cancelBag)
    }
}

