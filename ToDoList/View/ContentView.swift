//
//  ContentView.swift
//  ToDoList
//
//  Created by Vova on 25/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isShowingSheet = false
    @FetchRequest(entity: Task.entity(), sortDescriptors: [], predicate: nil, animation: .default) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            Group {
                if tasks.isEmpty {
                    Text("There is no task to do")
                        .font(.title)
                } else {
                    List {
                        ForEach(tasks, id: \.self) { task in
                            NavigationLink("\(task.taskName ?? "")", destination: TaskDescriptionView(task: task))
                        }
                        .onDelete { index in
                            PersistanceController.shared.delete(at: index)
                        }
                    }

                }
            }
            .navigationTitle("ToDoList")
            .toolbar {
                Button {
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            SheetView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
