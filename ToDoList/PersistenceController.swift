//
//  PersistenceController.swift
//  ToDoList
//
//  Created by Vova on 25/11/2021.
//

import Foundation
import CoreData

class PersistanceController {
    static let shared = PersistanceController()
    let container: NSPersistentContainer
    
    private init () {
        container = NSPersistentContainer(name: "CoreData")
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unsolved error: \(error)")
            }
        }
    }
    
    func saveContex() {
        do {
            try container.viewContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func delete(at offsets: IndexSet) {
        let tasks = getTasks()
        
        for index in offsets {
            let task = tasks[index]
            container.viewContext.delete(task)
        }
        
        saveContex()
    }
    
    func getTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func addTask(name: String, description: String) {
        let task = Task(context: container.viewContext)
        task.taskName = name
        task.taskDescription = description
        saveContex()
    }
}
