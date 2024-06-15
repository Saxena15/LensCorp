//
//  TodoInputForm.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//

import SwiftUI
import MapKit

struct TodoInputForm: View {
    // MARK: Core data variables
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @State var todo: Todo?
    
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var status: TodoStatus = .pending
    @State private var priority: Priority = .low

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter todo title", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    DatePicker("Select a date", selection: $date, displayedComponents: .date)
                } header: {
                    Text("Date")
                }
                
                Section {
                    Picker("Select status", selection: $status) {
                                            ForEach(TodoStatus.allCases, id: \.self) { status in
                                                Text(status.rawValue)
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Status")
                }
                Section {
                    Picker("Select priority", selection: $priority) {
                                            ForEach(Priority.allCases, id: \.self) { priority in
                                                Text(priority.rawValue)
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Priority")
                }

            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Save the data and dismiss the sheet
                        self.saveTodo(title: title, date: date, status: status.rawValue, priority: priority.rawValue)
                        // Call a function to handle saving or further processing of the newTodo
                        // For example, you can pass it to a delegate or callback.
                        isPresented = false
                    }
                }
            }
            .onAppear {
                if let todo = todo {
                    self.title = todo.title!
                    self.date = todo.date!
                    self.status = todo.status! == "completed" ? .completed : .pending
                }
            }
        }
    }

    func saveTodo(title: String, date: Date, status: String , priority: String) {
        if todo == nil {
            todo = Todo(context: self.viewContext)
            todo?.id = UUID()
        }
        todo?.title = title
        todo?.date = date
        todo?.status = status
        todo?.priority = priority
        
        do {
            try self.viewContext.save()
            print("Todo saved!")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
}

