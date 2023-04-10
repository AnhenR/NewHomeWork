//
//  SettingsViewModel.swift
//  TaskControl
//
//  Created by user on 10.04.23.
//

import Foundation

class SettingsViewModel {
    private let userDefaults = UserDefaults.standard
    
    var serverUrl: String {
        get { userDefaults.string(forKey: "serverUrl") ?? "" }
        set { userDefaults.set(newValue, forKey: "serverUrl") }
    }
    
    var maxListItems: Int {
        get { userDefaults.integer(forKey: "maxListItems") }
        set { userDefaults.set(newValue, forKey: "maxListItems") }
    }
    
    var defaultTaskDays: Int {
        get { userDefaults.integer(forKey: "defaultTaskDays") }
        set { userDefaults.set(newValue, forKey: "defaultTaskDays") }
    }
    
   
    func saveSettings() {
        userDefaults.synchronize()
    }
}

