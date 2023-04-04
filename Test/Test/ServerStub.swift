//
//  ServerStub.swift
//  Test
//
//  Created by user on 4.04.23.
//

import Foundation

class Bindable<T> {
    typealias Listener = ((T) -> Void)
    private var listeners: [Listener] = []
    var value: T {
        didSet {
            for listener in listeners {
                listener(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        listeners.append(listener)
        listener(value)
    }
}

protocol Project {
    var name: String { get }
    var description: String { get }
    init(name: String, description: String)
}

protocol Task {
    var statusIcon: String { get }
    var name: String { get }
    var project: Project { get }
    init(statusIcon: String, name: String, project: Project)
}

protocol Employee {
    var firstName: String { get }
    var lastName: String { get }
    var middleName: String { get }
    var position: String { get }
    init(firstName: String, lastName: String, middleName: String, position: String)
}

protocol ServerInterface {
    func getProjects(completion: @escaping ([Project]) -> Void)
    func getTasks(completion: @escaping ([Task]) -> Void)
    func getEmployees(completion: @escaping ([Employee]) -> Void)
}

class ProjectStub: Project {
    let nameBindable: Bindable<String>
    let descriptionBindable: Bindable<String>

    var name: String {
        get { nameBindable.value }
        set { nameBindable.value = newValue }
    }

    var description: String {
        get { descriptionBindable.value }
        set { descriptionBindable.value = newValue }
    }

    required init(name: String, description: String) {
        nameBindable = Bindable(name)
        descriptionBindable = Bindable(description)
    }

    func bindName(_ listener: @escaping (String) -> Void) {
        nameBindable.bind(listener: listener)
    }

    func bindDescription(_ listener: @escaping (String) -> Void) {
        descriptionBindable.bind(listener: listener)
    }
}


class TaskStub: Task {
    let statusIconBindable: Bindable<String>
    let nameBindable: Bindable<String>
    let projectBindable: Bindable<Project>

    var statusIcon: String {
        get { statusIconBindable.value }
        set { statusIconBindable.value = newValue }
    }

    var name: String {
        get { nameBindable.value }
        set { nameBindable.value = newValue }
    }

    var project: Project {
        get { projectBindable.value }
        set { projectBindable.value = newValue }
    }

    required init(statusIcon: String, name: String, project: Project) {
        self.statusIconBindable = Bindable(statusIcon)
        self.nameBindable = Bindable(name)
        self.projectBindable = Bindable(project)
    }

    func bindStatusIcon(_ listener: @escaping (String) -> Void) {
        statusIconBindable.bind(listener: listener)
    }

    func bindName(_ listener: @escaping (String) -> Void) {
        nameBindable.bind(listener: listener)
    }

    func bindProject(_ listener: @escaping (Project) -> Void) {
        projectBindable.bind(listener: listener)
    }
}

class EmployeeStub: Employee {
    let firstNameBindable: Bindable<String>
    let lastNameBindable: Bindable<String>
    let middleNameBindable: Bindable<String>
    let positionBindable: Bindable<String>

    var firstName: String {
        get { firstNameBindable.value }
        set { firstNameBindable.value = newValue }
    }

    var lastName: String {
        get { lastNameBindable.value }
        set { lastNameBindable.value = newValue }
    }

    var middleName: String {
        get { middleNameBindable.value }
        set { middleNameBindable.value = newValue }
    }

    var position: String {
        get { positionBindable.value }
        set { positionBindable.value = newValue }
    }

    required init(firstName: String, lastName: String, middleName: String, position: String) {
        self.firstNameBindable = Bindable(firstName)
        self.lastNameBindable = Bindable(lastName)
        self.middleNameBindable = Bindable(middleName)
        self.positionBindable = Bindable(position)
    }

    func bindFirstName(_ listener: @escaping (String) -> Void) {
        firstNameBindable.bind(listener: listener)
    }

    func bindLastName(_ listener: @escaping (String) -> Void) {
        lastNameBindable.bind(listener: listener)
    }

    func bindMiddleName(_ listener: @escaping (String) -> Void) {
        middleNameBindable.bind(listener: listener)
    }

    func bindPosition(_ listener: @escaping (String) -> Void) {
        positionBindable.bind(listener: listener)
    }
}


class ServerStub: ServerInterface {
    var projects: [Project] = [
        ProjectStub(name: "Project 1", description: "Description 1"),
        ProjectStub(name: "Project 2", description: "Description 2"),
        ProjectStub(name: "Project 3", description: "Description 3"),
        ProjectStub(name: "Project 4", description: "Description 4")
    ]
    
    var tasks: [Task] = [
        TaskStub(statusIcon: "⏳", name: "Task 1", project: ProjectStub(name: "Project 1", description: "Description 1")),
        TaskStub(statusIcon: "✔️", name: "Task 2", project: ProjectStub(name: "Project 2", description: "Description 2")),
        TaskStub(statusIcon: "❌", name: "Task 3", project: ProjectStub(name: "Project 3", description: "Description 3"))
    ]
    
    var employees: [Employee] = [
        EmployeeStub(firstName: "John", lastName: "Doe", middleName: "", position: "Developer"),
        EmployeeStub(firstName: "Jane", lastName: "Doe", middleName: "", position: "Designer"),
        EmployeeStub(firstName: "Bob", lastName: "Smith", middleName: "", position: "Manager")
    ]
    
    func getProjects(completion: @escaping ([Project]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.projects)
        }
    }
    
    func getTasks(completion: @escaping ([Task]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.tasks)
        }
    }
    
    func getEmployees(completion: @escaping ([Employee]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.employees)
        }
    }
    
    func addProject(_ project: Project, completion: @escaping () -> Void) {
           self.projects.append(project)
           completion()
       }
    
    func addTask(_ task: Task, completion: @escaping () -> Void) {
           self.tasks.append(task)
           completion()
       }
       
       func deleteTask(at index: Int, completion: @escaping () -> Void) {
           self.tasks.remove(at: index)
           completion()
       }
}
