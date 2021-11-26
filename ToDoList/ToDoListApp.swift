//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Vova on 25/11/2021.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        let contex = PersistanceController.shared.container.viewContext
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, contex)
        }
    }
}
