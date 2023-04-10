//
//  Bindable.swift
//  TaskControl
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
