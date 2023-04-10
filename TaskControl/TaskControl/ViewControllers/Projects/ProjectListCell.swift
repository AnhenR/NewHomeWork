//
//  ProjectListCell.swift
//  TaskControl
//
//  Created by user on 2.04.23.
//

import Foundation
import UIKit

class ProjectListCell: UITableViewCell {
    
    var onDelete: (() -> Void)?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let tasksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Задачи", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
         button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .leading
        labelStackView.spacing = 8
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStackView = UIStackView(arrangedSubviews: [tasksButton, changeButton, deleteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(labelStackView)
        contentView.addSubview(buttonStackView)
        
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
    
    @objc func didTapDelete() {
        onDelete?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

