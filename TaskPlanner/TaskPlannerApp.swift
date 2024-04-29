//
//  TaskPlannerApp.swift
//  TaskPlanner
//
//  Created by Deimante Valunaite on 19/04/2024.
//

import SwiftUI

@main
struct TaskPlannerApp: App {
    
    var body: some Scene {
        WindowGroup {
           TaskView()
        }
        .modelContainer(for: Task.self)
    }
}
