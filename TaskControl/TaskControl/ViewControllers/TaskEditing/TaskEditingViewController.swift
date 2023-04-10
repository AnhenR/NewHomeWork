//
//  TaskEditingViewController.swift
//  TaskControl
//
//  Created by user on 5.04.23.
//

import Foundation
import UIKit

class TaskEditingViewController: UIViewController {
    
    var viewModel = TaskEditingViewModel(server: ServerStub())
    
    var textField1Data: String?
    
    private var textFieldArray = [UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField()]
    
    private var buttonArray = [UIButton(),UIButton()]
    
    private var projectPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 40
        return picker
    }()
    
    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.tag = 60
        picker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return picker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.tag = 70
        picker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return picker
    }()
    
    private var statusPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 80
        return picker
    }()
    
    private var employeePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 90
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureButton()
        projectPicker.delegate = self
        projectPicker.dataSource = self
        statusPicker.delegate = self
        statusPicker.dataSource = self
        employeePicker.delegate = self
        employeePicker.dataSource = self
        configureTextField()
        
        viewModel.getProjects()
        viewModel.getEmployees()
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
        let num = [3,4,5,6,7,8,9]
        let placeholder = ["Наименование","Выбор проекта", "Количество часов на выполнение", "Дата начала","Дата окончания", "Статус", "Исполнитель"]
        textFieldArray.enumerated().forEach{ index ,field in
            view.addSubview(field)
            field.translatesAutoresizingMaskIntoConstraints = false
            textFieldArray[index].tag = num[index]
            textFieldArray[index].placeholder = placeholder[index]
            textFieldArray[index].borderStyle = .roundedRect
            
            textFieldArray[index].topAnchor.constraint(equalTo: index == 0 ? view.safeAreaLayoutGuide.topAnchor : textFieldArray[index - 1].bottomAnchor, constant: index == 0 ? 20 : 20).isActive = true
            textFieldArray[index].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            textFieldArray[index].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            textFieldArray[index].heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            textFieldArray[index].delegate = self
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .lightGray
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 3:
            textField.keyboardType = .alphabet
        case 4:
            textField.inputView = projectPicker
        case 5:
            textField.keyboardType = .alphabet
        case 6:
            textField.inputView = startDatePicker
        case 7:
            textField.inputView = endDatePicker
        case 8:
            textField.inputView = statusPicker
        case 9:
            textField.inputView = employeePicker
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 3:
            textField.resignFirstResponder()
            return true
        case 5:
            textField.resignFirstResponder()
            return true
        default:
            return false
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: sender.date)
        
        guard let textField = view.viewWithTag(sender.tag / 10) as? UITextField else {
            return
        }
        
        textField.text = dateString
        textField.resignFirstResponder()
    }
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            guard let textField1 = view.viewWithTag(3) as? UITextField else { return }
               textField1Data = textField1.text
            print("Text Field 1 Data: \(textField1Data ?? "")")
        case 2 :
            print("2")
        default:
            print("Error")
        }
    }
}

extension TaskEditingViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 40 :
            return viewModel.projects.value.count
        case 80 :
            return viewModel.icone.count
        case 90 :
            return viewModel.employees.value.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 40 :
            return viewModel.projects.value[row].name
        case 80 :
            return viewModel.icone[row]
        case 90 :
            return viewModel.employees.value[row].surname
        default:
            return "no"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let selectedTextField = view.viewWithTag(pickerView.tag / 10) as? UITextField else {
            return
        }
        
        switch pickerView.tag {
        case 40:
            selectedTextField.text = viewModel.projects.value[row].name
        case 80:
            selectedTextField.text = viewModel.icone[row]
        case 90:
            selectedTextField.text = viewModel.employees.value[row].surname
        default:
            return
        }
        selectedTextField.resignFirstResponder()
    }
}

