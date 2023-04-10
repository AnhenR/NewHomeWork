//
//  MainMenuViewController.swift
//  TaskControl
//
//  Created by user on 29.03.23.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController {

    private var buttonArray = [UIButton(),UIButton(),UIButton(),UIButton()]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        makeButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = "Назад"
        navigationController?.navigationBar.isHidden = false
    }

    private func makeButton() {
        let num = [1,2,3,4]
        let title = ["Проекты","Задачи","Сотрудники","Настройки"]

        buttonArray.enumerated().forEach{ index ,button in
            button.backgroundColor = .darkGray
            button.layer.cornerRadius = 20
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addShadow()
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            view.addSubview(button)
            buttonArray[index].tag = num[index]
            buttonArray[index].setTitle(title[index], for: .normal)

            buttonArray[index].topAnchor.constraint(equalTo: index == 0 ? view.topAnchor : buttonArray[index - 1].bottomAnchor, constant: index == 0 ? 200 : 5 ).isActive = true
            buttonArray[index].leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            buttonArray[index].trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            buttonArray[index].widthAnchor.constraint(equalToConstant: 100).isActive = true
            buttonArray[index].heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
    }

    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            navigationController?.pushViewController(ProjectListViewController(), animated: true)
        case 2 :
            navigationController?.pushViewController(TaskListViewController(), animated: true)
        case 3 :
            navigationController?.pushViewController(EmployeeListViewController(), animated: true)
        case 4 :
            navigationController?.pushViewController(SettingsViewController(), animated: true)
        default:
            print("Error")
        }
    }
}
