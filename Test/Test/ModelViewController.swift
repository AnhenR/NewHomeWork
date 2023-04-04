//
//  ModelViewController.swift
//  Test
//
//  Created by user on 4.04.23.
//

import Foundation

class ModelViewController {
    
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
}
