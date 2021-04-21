//
//  Task.swift
//  lesson_5_hw
//
//  Created by Юрий Егоров on 20.04.2021.
//

import Foundation

protocol Task {
    var name: String { get }
    
    func addSubtask(task: Subtask)
}

class Subtask: Task {
    var name: String
    var subtasks: [Subtask] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addSubtask(task: Subtask) {
        self.subtasks.append(task)
    }
}
