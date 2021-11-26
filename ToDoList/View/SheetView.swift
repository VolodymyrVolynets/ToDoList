//
//  SheetView.swift
//  ToDoList
//
//  Created by Vova on 26/11/2021.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var taskName = ""
    @State private var taskDescription = ""
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Task Name: ")
                TextField("Enter Task Name", text: $taskName)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack {
                Text("Task Description: ")
                TextField("Enter Task Description", text: $taskDescription)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
                
                guard taskName != "" else { return }
                PersistanceController.shared.addTask(name: taskName, description: taskDescription)
            } label: {
                Text("Add Task")
            }
            
        }
        .padding()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
