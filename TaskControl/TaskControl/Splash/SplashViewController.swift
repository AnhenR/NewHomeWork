//
//  SplashViewController.swift
//  TaskControl
//
//  Created by user on 29.03.23.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let nameLabel: UILabel = {
      let label = UILabel()
        label.text = "Управление задачами"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addShadow()
        return label
    }()
    
    private let versionLabel: UILabel = {
      let label = UILabel()
        label.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.6
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.navigationController?.pushViewController(MainMenuViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
}
    
    private func configureUI() {
        view.addSubviews(nameLabel, versionLabel)
        view.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            nameLabel.widthAnchor.constraint(equalToConstant: 300),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            versionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
