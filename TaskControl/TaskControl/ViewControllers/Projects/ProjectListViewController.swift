//
//  ProjectListViewController.swift
//  TaskControl
//
//  Created by user on 1.04.23.
//

import Foundation
import UIKit

class ProjectListViewController: UIViewController {
    
    private var viewModel = ProjectListViewModel(server: ServerStub())
    
    private var projectsTableView = UITableView()
    
    private var buttonArray = [UIButton(),UIButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .lightGray
        configureTable()
        configureUI()
        viewModel.projects.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.projectsTableView.reloadData()
            }
        }
        viewModel.getProjects()
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
        view.addSubview(projectsTableView)
        projectsTableView.translatesAutoresizingMaskIntoConstraints = false
        projectsTableView.layer.cornerRadius = 10
        projectsTableView.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            projectsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            projectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            projectsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            projectsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        projectsTableView.register(ProjectListCell.self, forCellReuseIdentifier: "ProjectListCell")
    }
    
    @objc private func didTapButton(sender: UIButton) {
        switch sender.tag {
        case 1 :
            projectsTableView.reloadData()
            print("reload")
        case 2 :
            navigationController?.pushViewController(ProjectEditingViewController(), animated: true)
        default:
            print("Error")
        }
    }
}

extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projects.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath) as! ProjectListCell
        
        cell.backgroundColor = .lightGray
        
        let project = viewModel.projects.value[indexPath.row]
        
        cell.nameLabel.text = project.name
        cell.descriptionLabel.text = project.description
        cell.tasksButton.addTarget(self, action: #selector(didTapTasks), for: .touchUpInside)
        cell.changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return cell
    }
    
    @objc func didTapTasks() {
        navigationController?.pushViewController(TaskListViewController(), animated: true)
    }
    
    @objc func didTapChange() {
        print("Button 2 tapped")
    }
    
    @objc func didTapDelete(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? ProjectListCell,
              let indexPath = projectsTableView.indexPath(for: cell) else {
                  return
              }
        // Вызываем функцию удаления проекта во вью модели
        viewModel.deleteProject1(at: indexPath.row)
        projectsTableView.reloadData()
        print("Button 3 tapped")
    }

}


