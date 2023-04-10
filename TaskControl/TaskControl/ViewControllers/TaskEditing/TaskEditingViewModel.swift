//
//  TaskEditingViewModel.swift
//  TaskControl
//
//  Created by user on 6.04.23.
//

import Foundation

class TaskEditingViewModel {
    
    let server: ServerInterface
    var projects: Bindable<[Project]> = Bindable([])
    var employees: Bindable<[Employee]> = Bindable([])
    var icone = ["❌", "⏳", "✅", "🗓️"]
    
    init(server: ServerInterface) {
        self.server = server
    }
    
    func getProjects() {
        server.getProjects { [weak self] projects in
            self?.projects.value = projects
        }
    }
    
    func getEmployees() {
        server.getEmployees { [weak self] employees in
            self?.employees.value = employees
        }
    }
    
}
