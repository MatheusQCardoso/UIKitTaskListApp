//
//  Constants.swift
//  TaskList
//
//  Created by Matheus Quirino on 01/01/22.
//

import Foundation

struct Constants{
    static let DATA_SETUP = "tasklist_setup"
    static let TASK_COUNT = "tasklist_taskcount"
    static let TASK_IDENTIFIER: (Int) -> String = { i in
        return "tasklist_task\(i)"
    }
}
