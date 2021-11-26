//
//  TaskDescriptionView.swift
//  ToDoList
//
//  Created by Vova on 26/11/2021.
//

import SwiftUI

struct TaskDescriptionView: View {
    private var task: Task
    @State private var name: String
    @State private var description: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(task: FetchedResults<Task>.Element) {
        self.task = task
        self._name = State(initialValue: task.taskName ?? "")
        self._description = State(initialValue: task.taskDescription ?? "")
    }
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Task Name: ")
                TextField("Enter Task Name", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Task Description: ")
                TextField("Enter Task Description", text: $description)
                    .textFieldStyle(.roundedBorder)
            }
    
            Button {
                presentationMode.wrappedValue.dismiss()
                
                guard name != "" else { return }
                self.task.taskName = name
                self.task.taskDescription = description
                
                PersistanceController.shared.saveContex()
            } label: {
                Text("Update Task")
            }
        }
        .padding()
    }
}

struct TaskDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PersistanceController.shared.addTask(name: "Test", description: "Test")
        return TaskDescriptionView(task: PersistanceController.shared.getTasks()[0])
    }
}
