//
//  ProjectListViewModel.swift
//  TaskControl
//
//  Created by user on 2.04.23.
//

import Foundation
import UIKit

class ProjectListViewModel{
    
    let server: ServerInterface
    var projects: Bindable<[Project]> = Bindable([])
    
    init(server: ServerInterface) {
        self.server = server
    }
    
    func getProjects() {
        server.getProjects { [weak self] projects in
            self?.projects.value = projects
        }
    }
    
    func deleteProject(name: String) {
        server.deleteProjectByName(name)
    }
    
    func deleteProject1(at index: Int) {
           server.deleteProject1(at: index) { [weak self] in
               guard let self = self else { return }
               var updatedProjects = self.projects.value
               updatedProjects.remove(at: index)
               self.projects.value = updatedProjects
           }
       }
}
