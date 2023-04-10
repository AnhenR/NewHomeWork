//
//  SettingsViewController.swift
//  TaskControl
//
//  Created by user on 6.04.23.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private var buttonArray = [UIButton(),UIButton()]
    
    private var textFieldArray = [UITextField(),UITextField(),UITextField()]
    
    private let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .lightGray
        configureButton()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let serverUrl = view.viewWithTag(3) as? UITextField else { return }
        serverUrl.text = viewModel.serverUrl
        guard let maxListItems = view.viewWithTag(4) as? UITextField else { return }
        maxListItems.text = "\(viewModel.maxListItems)"
        guard let defaultTaskDays = view.viewWithTag(5) as? UITextField else { return }
        defaultTaskDays.text = "\(viewModel.defaultTaskDays)"
        
    }
    
    private func configureButton() {
        let num = [1,2]
        let title = ["Отмена","Сохранить"]
        buttonArray.enumerated().forEach{ index ,button in
            button.backgroundColor = .darkGray
            button.layer.cornerRadius = 20
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addShadow()
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            view.addSubview(button)
            buttonArray[index].tag = num[index]
            buttonArray[index].setTitle(title[index], for: .normal)
            
            buttonArray[index].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
            buttonArray[index].trailingAnchor.constraint(equalTo: index == 0 ? view.trailingAnchor : buttonArray[index - 1].leadingAnchor, constant: -10).isActive = true
            buttonArray[index].widthAnchor.constraint(equalToConstant: 100).isActive = true
            buttonArray[index].heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
    }
    
    private func configureTextField() {
        let num = [3,4,5]
        let placeholder = ["URL","Максимально количество записей", "Количество дней на выполнение"]
        textFieldArray.enumerated().forEach{ index ,field in
            view.addSubview(field)
            field.translatesAutoresizingMaskIntoConstraints = false
            textFieldArray[index].tag = num[index]
            textFieldArray[index].placeholder = placeholder[index]
            textFieldArray[index].borderStyle = .roundedRect
            
            textFieldArray[index].topAnchor.constraint(equalTo: index == 0 ? view.safeAreaLayoutGuide.topAnchor : textFieldArray[index - 1].bottomAnchor, constant: index == 0 ? 40 : 20).isActive = true
            textFieldArray[index].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            textFieldArray[index].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            textFieldArray[index].heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            textFieldArray[index].delegate = self
        }
    }
    
    func saveSattings() {
        guard let serverUrl = view.viewWithTag(3) as? UITextField else { return }
        viewModel.serverUrl = serverUrl.text ?? ""
        print("Text Field 1 Data: \(serverUrl.text ?? "")")
        guard let maxListItems = view.viewWithTag(4) as? UITextField else { return }
        viewModel.maxListItems = Int(maxListItems.text ?? "") ?? 10
        print("Text Field 2 Data: \(maxListItems.text ?? "")")
        guard let defaultTaskDays = view.viewWithTag(5) as? UITextField else { return }
        viewModel.defaultTaskDays = Int(defaultTaskDays.text ?? "") ?? 10
        print("Text Field 3 Data: \(defaultTaskDays.text ?? "")")
        viewModel.saveSettings()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            navigationController?.popViewController(animated: true)
        case 2 :
            saveSattings()
        default:
            print("Error")
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

