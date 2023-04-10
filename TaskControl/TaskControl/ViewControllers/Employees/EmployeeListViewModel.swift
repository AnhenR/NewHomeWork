//
//  EmployeeListViewModel.swift
//  TaskControl
//
//  Created by user on 4.04.23.
//

import Foundation

class EmployeeListViewModel {
    
    let server: ServerInterface
    var employees: Bindable<[Employee]> = Bindable([])
    
    init(server: ServerInterface) {
        self.server = server
    }
    
    func getEmployees() {
        server.getEmployees { [weak self] employees in
            self?.employees.value = employees
        }
    }
}
