//
//  TaskListViewModel.swift
//  TaskControl
//
//  Created by user on 3.04.23.
//

import Foundation
import UIKit

class TaskListViewModel {
    
    let server: ServerInterface
    var tasks: Bindable<[Task]> = Bindable([])
    
    init(server: ServerInterface) {
        self.server = server
    }
    
    func getTasks() {
        server.getTasks { [weak self] tasks in
            self?.tasks.value = tasks
        }
    }
}
