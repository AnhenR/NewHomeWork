//
//  ViewController.swift
//  Test
//
//  Created by user on 29.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()

    var viewModel = ModelViewController(server: ServerStub())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        navigationItem.leftBarButtonItem = nil
        configureTable()
               // подписываемся на изменения свойства projects
               viewModel.projects.bind { [weak self] _ in
                   DispatchQueue.main.async {
                       self?.tableView.reloadData()
                   }
               }

               // получаем список проектов
               viewModel.getProjects()

    }
    
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .gray
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return projects.count
        return viewModel.projects.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let project = viewModel.projects.value[indexPath.row]
        cell.titleLabel.text = project.name
        cell.subtitleLabel.text = project.description
        cell.titleLabel.textColor = .black
        cell.button1.setTitle("Задачи", for: .normal)
        cell.button2.setTitle("Изменить", for: .normal)
        cell.button3.setTitle("Удалить", for: .normal)
        cell.button1.addTarget(self, action: #selector(didTapButton1), for: .touchUpInside)
        cell.button2.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        cell.button3.addTarget(self, action: #selector(didTapButton3), for: .touchUpInside)
        return cell
    }
    
    @objc func didTapButton1() {
//        server.addProject(ProjectStub(name: "Project 4", description: "Description 4")) { [self] in
//            self.projects = self.server.projects
//            self.tableView.reloadData()
//            print("lol")
//        }
    print("lol")
    }
    
    @objc func didTapButton2() {
        print("Button 2 tapped")
    }
    
    @objc func didTapButton3() {
        print("Button 3 tapped")
    }
    
}





//protocol SplashPresenterDescription {
//    func present()
//    func dismiss(completion: (() -> Void)?)
//}
//
//final class SplashPresenter: SplashPresenterDescription {
//
//    private lazy var foregroundSplashWindow: UIWindow = {
//        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let splashViewController = storyboard.instantiateViewController(identifier: "SplashViewController") as? SplashViewController
//
//        splashWindow.windowLevel = .normal + 1
//        splashWindow.rootViewController = splashViewController
//        
//        return splashWindow
//    }()
//
//    func present() {
//        foregroundSplashWindow.isHidden = false
//    }
//
//    func dismiss(completion: (() -> Void)?) {
//        UIView.animate(withDuration: 0.3) {
//            self.foregroundSplashWindow.alpha = 0
//        } completion: { (_) in
//            completion?()
//        }
//
//    }
//}
