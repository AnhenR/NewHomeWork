//
//  EmployeeListViewController.swift
//  TaskControl
//
//  Created by user on 4.04.23.
//

import Foundation
import UIKit

class EmployeeListViewController: UIViewController {

    private var viewModel = EmployeeListViewModel(server: ServerStub())

    private var employeeTableView = UITableView()

    private var buttonArray = [UIButton(),UIButton()]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTable()
        configureUI()
        viewModel.employees.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.employeeTableView.reloadData()
            }
        }
        viewModel.getEmployees()
    }

    private func configureUI() {
        navigationItem.backButtonTitle = "Назад"
        let num = [1,2]
        let title = ["Обновить","Добавить"]
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

    private func configureTable() {
        view.addSubview(employeeTableView)
        employeeTableView.translatesAutoresizingMaskIntoConstraints = false
        employeeTableView.layer.cornerRadius = 10
        employeeTableView.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            employeeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            employeeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            employeeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            employeeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        employeeTableView.register(EmployeeListCell.self, forCellReuseIdentifier: "EmployeeListCell")
    }

    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            employeeTableView.reloadData()
            print("reload")
        case 2 :
            navigationController?.pushViewController(EmployeeEditingViewController(), animated: true)
            print("k")
        default:
            print("Error")
        }
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListCell", for: indexPath) as! EmployeeListCell

        cell.backgroundColor = .lightGray

        let employee = viewModel.employees.value[indexPath.row]

        cell.surnameLabel.text = employee.surname
        cell.nameLabel.text = employee.name
        cell.patronymicLabel.text = employee.patronymic
        cell.positionLabel.text = employee.position
        cell.changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return cell
    }
    
    @objc func didTapChange() {
        navigationController?.pushViewController(EmployeeEditingViewController(), animated: true)
        print("Button 2 tapped")
    }

    @objc func didTapDelete() {
        print("Button 3 tapped")
    }

}


