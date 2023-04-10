
//  EmployeeEditingViewController.swift
//  TaskControl
//
//  Created by user on 5.04.23.


import Foundation
import UIKit

class EmployeeEditingViewController: UIViewController {
    
    private var buttonArray = [UIButton(),UIButton()]
    
    private var textFieldArray = [UITextField(),UITextField(),UITextField(),UITextField()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTextField()
        configureButton()
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
        let num = [3,4,5,6]
        let placeholder = ["Фамилия","Имя", "Отчество", "Должность"]
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
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            navigationController?.popViewController(animated: true)
        case 2 :
            guard let textField1 = view.viewWithTag(3) as? UITextField else { return }
            print("Text Field 1 Data: \(textField1.text ?? "")")
        default:
            print("Error")
        }
    }
}

extension EmployeeEditingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}



//
//  // Функция делегата UITextFieldDelegate, вызывается при завершении редактирования текстового поля
//  func textFieldDidEndEditing(_ textField: UITextField) {
//      if textField.tag == 0 {
//          print("Введен текст в первое поле ввода: \(textField.text ?? "")")
//      } else if textField.tag == 1 {
//          print("Введен текст во второе поле ввода: \(textField.text ?? "")")
//      }
//  }
//}
