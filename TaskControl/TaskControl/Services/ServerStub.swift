//
//  ServerStub.swift
//  TaskControl
//
//  Created by user on 4.04.23.
//

import Foundation

protocol Project: class {
    var name: String { get }
    var description: String { get }
    init(name: String, description: String)
}

protocol Task {
    var statusIcon: String { get }
    var name: String { get }
    var work: Int { get }
    var startDate: String { get }
    var endDate: String { get }
    var employee: Employee { get }
    var project: Project { get }
    
    init(statusIcon: String, name: String, work: Int, startDate: String, endDate: String, employee: Employee, project: Project)
}

protocol Employee {
    var surname: String { get }
    var name: String { get }
    var patronymic: String { get }
    var position: String { get }
    init(surname: String, name: String, patronymic: String, position: String)
}

protocol ServerInterface {
    func getProjects(completion: @escaping ([Project]) -> Void)
    func getTasks(completion: @escaping ([Task]) -> Void)
    func getEmployees(completion: @escaping ([Employee]) -> Void)
    
    func addProject(_ project: Project, completion: @escaping (Bool) -> Void)
    func deleteProject(_ project: Project)
    
    func deleteProjectByName(_ name: String)
    func deleteProject1(at index: Int, completion: @escaping () -> Void)
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
    let workBindable: Bindable<Int>
    let startDateBindable: Bindable<String>
    let endDateBindable: Bindable<String>
    let employeeBindable: Bindable<Employee>
    let projectBindable: Bindable<Project>
    
    var statusIcon: String {
        get { statusIconBindable.value }
        set { statusIconBindable.value = newValue }
    }
    
    var name: String {
        get { nameBindable.value }
        set { nameBindable.value = newValue }
    }
    
    var work: Int {
        get { workBindable.value }
        set { workBindable.value = newValue }
    }
    
    var startDate: String {
        get { startDateBindable.value }
        set { startDateBindable.value = newValue }
    }
    
    var endDate: String {
        get { endDateBindable.value }
        set { endDateBindable.value = newValue }
    }
    
    var employee: Employee {
        get { employeeBindable.value }
        set { employeeBindable.value = newValue }
    }
    
    var project: Project {
        get { projectBindable.value }
        set { projectBindable.value = newValue }
    }
    
    required init(statusIcon: String, name: String, work: Int, startDate: String, endDate: String, employee: Employee, project: Project) {
        self.statusIconBindable = Bindable(statusIcon)
        self.nameBindable = Bindable(name)
        self.workBindable = Bindable(work)
        self.startDateBindable = Bindable(startDate)
        self.endDateBindable = Bindable(endDate)
        self.employeeBindable = Bindable(employee)
        self.projectBindable = Bindable(project)
    }
    
    func bindStatusIcon(_ listener: @escaping (String) -> Void) {
        statusIconBindable.bind(listener: listener)
    }
    
    func bindName(_ listener: @escaping (String) -> Void) {
        nameBindable.bind(listener: listener)
    }
    
    func bindWork(_ listener: @escaping (Int) -> Void) {
        workBindable.bind(listener: listener)
    }
    
    func bindStartDate(_ listener: @escaping (String) -> Void) {
        startDateBindable.bind(listener: listener)
    }
    
    func bindEndDate(_ listener: @escaping (String) -> Void) {
        endDateBindable.bind(listener: listener)
    }
    
    func bindEmployee(_ listener: @escaping (Employee) -> Void) {
        employeeBindable.bind(listener: listener)
    }
    
    func bindProject(_ listener: @escaping (Project) -> Void) {
        projectBindable.bind(listener: listener)
    }
}

class EmployeeStub: Employee {
    let surnameBindable: Bindable<String>
    let nameBindable: Bindable<String>
    let patronymicBindable: Bindable<String>
    let positionBindable: Bindable<String>
    
    var surname: String {
        get { surnameBindable.value }
        set { surnameBindable.value = newValue }
    }
    
    var name: String {
        get { nameBindable.value }
        set { nameBindable.value = newValue }
    }
    
    var patronymic: String {
        get { patronymicBindable.value }
        set { patronymicBindable.value = newValue }
    }
    
    var position: String {
        get { positionBindable.value }
        set { positionBindable.value = newValue }
    }
    
    required init(surname: String, name: String, patronymic: String, position: String) {
        self.surnameBindable = Bindable(surname)
        self.nameBindable = Bindable(name)
        self.patronymicBindable = Bindable(patronymic)
        self.positionBindable = Bindable(position)
    }
    
    func bindFirstName(_ listener: @escaping (String) -> Void) {
        surnameBindable.bind(listener: listener)
    }
    
    func bindLastName(_ listener: @escaping (String) -> Void) {
        nameBindable.bind(listener: listener)
    }
    
    func bindMiddleName(_ listener: @escaping (String) -> Void) {
        patronymicBindable.bind(listener: listener)
    }
    
    func bindPosition(_ listener: @escaping (String) -> Void) {
        positionBindable.bind(listener: listener)
    }
}


class ServerStub: ServerInterface {
    var projects: [Project] = [
        ProjectStub(name: "Проект 1", description: "Описание 1"),
        ProjectStub(name: "Проект 2", description: "Описание 2"),
        ProjectStub(name: "Проект 3", description: "Описание 3"),
        ProjectStub(name: "Проект 4", description: "Описание 4")
    ]
    
    var tasks: [Task] = [
        TaskStub(statusIcon: "❌", name: "Задача 1",work: 20, startDate: "2023.05.09", endDate: "2023.05.08", employee: EmployeeStub(surname: "", name: "", patronymic: "", position: ""), project: ProjectStub(name: "Проект 1", description: "Описание 1"))
    ]
    
    var employees: [Employee] = [
        EmployeeStub(surname: "Петровна", name: "Юлия", patronymic: "", position: "Разработчик"),
        EmployeeStub(surname: "Иванова", name: "Анна", patronymic: "", position: "Разработчик"),
        EmployeeStub(surname: "Сидорова", name: "Мария", patronymic: "", position: "Разработчик")
    ]
    
    func getProjects(completion: @escaping ([Project]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.projects)
        }
    }
    
    func getTasks(completion: @escaping ([Task]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.tasks)
        }
    }
    
    func getEmployees(completion: @escaping ([Employee]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.employees)
        }
    }
    
    //    func addProject(_ project: Project, completion: @escaping () -> Void) {
    //        self.projects.append(project)
    //        completion()
    //    }
    
    func addProject(_ project: Project, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.projects.append(project)
            completion(true)
        }
    }
    
    func deleteProject1(at index: Int, completion: @escaping () -> Void) {
        self.projects.remove(at: index)
        completion()
    }
    
    func deleteProject(_ project: Project) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.projects.removeAll(where: { $0.name == project.name })
        }
    }
    
    func deleteProjectByName(_ name: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let index = self.projects.firstIndex(where: { $0.name == name }) {
                self.projects.remove(at: index)
            }
        }
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
