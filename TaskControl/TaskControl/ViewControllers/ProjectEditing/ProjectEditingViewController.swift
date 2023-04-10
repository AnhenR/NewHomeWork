//
//  ProjectEditingViewController.swift
//  TaskControl
//
//  Created by user on 3.04.23.
//

import Foundation
import UIKit

class ProjectEditingViewController: UIViewController {
    
    var viewModel = ProjectEditingViewModel(server: ServerStub())
    
    private let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Наименование"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Описание"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var buttonArray = [UIButton(),UIButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureButton()
        nameTextField.delegate = self
        descriptionTextField.delegate = self
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
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .lightGray
        view.addSubviews(nameTextField, descriptionTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            navigationController?.popViewController(animated: true)
        case 2 :
            viewModel.addProject(ProjectStub(name: "\(nameTextField.text ?? "")", description: "\(descriptionTextField.text ?? "")"))
            print("2\(nameTextField.text ?? "")")
           
        default:
            print("Error")
        }
    }

}

extension ProjectEditingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
