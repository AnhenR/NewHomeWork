//
//  ProjectEditingViewModel.swift
//  TaskControl
//
//  Created by user on 6.04.23.
//

import Foundation

class ProjectEditingViewModel {
    
    let server: ServerInterface
    var projects: Bindable<[Project]> = Bindable([])
    
    init(server: ServerInterface) {
        self.server = server
    }
    
    func addProject(_ project: Project) {
        var currentProjects = projects.value
        currentProjects.append(project)
        projects.value = currentProjects
        server.addProject(project) { [weak self] success in
            guard success else { return }
            self?.projects.value = currentProjects
        }
    }
}
