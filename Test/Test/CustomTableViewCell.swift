//
//  CustomTableViewCell.swift
//  Test
//
//  Created by user on 2.04.23.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0 // Многострочный текст
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // Многострочный текст
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 1", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 3", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Создаем стек для заголовка и подзаголовка
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .leading
        labelStackView.spacing = 8
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем стек для кнопок
        let buttonStackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем оба стека в контентView
        contentView.addSubview(labelStackView)
        contentView.addSubview(buttonStackView)
        
        // Определяем layoutConstraints для обоих стеков
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -16),
            
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with project: Project) {
        titleLabel.text = project.name
        subtitleLabel.text = project.description
        }

}


