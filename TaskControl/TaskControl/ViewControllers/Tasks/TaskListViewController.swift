//
//  TaskListViewController.swift
//  TaskControl
//
//  Created by user on 3.04.23.
//

import Foundation
import UIKit

class TaskListViewController: UIViewController {
    
    private let viewModel = TaskListViewModel(server: ServerStub())
    
    private var taskTableView = UITableView()
    
    private var buttonArray = [UIButton(),UIButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .lightGray
        configureTable()
        configureUI()
        
        viewModel.tasks.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.taskTableView.reloadData()
            }
        }
        viewModel.getTasks()
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
        view.addSubview(taskTableView)
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        taskTableView.layer.cornerRadius = 10
        taskTableView.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            taskTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            taskTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCell")
    }
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            taskTableView.reloadData()
            print("reload")
        case 2 :
            navigationController?.pushViewController(TaskEditingViewController(), animated: true)
            print("Error")
        default:
            print("Error")
        }
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        
        cell.backgroundColor = .lightGray
        
        let task = viewModel.tasks.value[indexPath.row]
        
        cell.iconLabel.text = task.statusIcon
        cell.nameLabel.text = task.name
        cell.projectNameLabel.text = task.project.name
        cell.changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return cell
    }
    
    @objc func didTapChange() {
        print("Button 2 tapped")
    }
    
    @objc func didTapDelete() {
        print("Button 3 tapped")
    }

}
