//
//  ContentView.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    
    // MARK: user typed keyword
    @State var searchKeyword: String = ""
    @State var isSheetPresented: Bool = false
    @State var isDashboardPresented: Bool = false
    @FetchRequest(sortDescriptors: []) private var todos: FetchedResults<Todo>
    @State var ticketsDone : Double = 2
    @State var ticketsNotDone : Int = 3
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos, id: \.self) { todo in
                    NavigationLink(destination: TodoDetailView(todo: todo)) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(todo.title ?? "")
                                        .font(.title3)
                                    
                                    Spacer()
                                    Text(todo.priority ?? Priority.low.rawValue)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                               
                                Text(formatDate(todo.date ?? Date()))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
                        }.onAppear {
                            if todo.status?.lowercased() == TodoStatus.completed.rawValue.lowercased(){
                                ticketsDone = ticketsDone + 1
                                
                            }else if todo.status?.lowercased() == TodoStatus.pending.rawValue.lowercased(){
                                ticketsNotDone = ticketsNotDone +  1
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.inset)
            .padding()
            .navigationTitle("Home")
            // MARK: Add searchable modifier
            .searchable(text: $searchKeyword)
            .onChange(of: searchKeyword) { newValue in
                self.todos.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "title CONTAINS %@", newValue)
            }
            .sheet(isPresented: $isSheetPresented, content: {
                TodoInputForm(isPresented: $isSheetPresented)
            })
            .sheet(isPresented: $isDashboardPresented , content: {
                Dashboard(data: PieChartData(dataSets: PieDataSet(
                    dataPoints: [
                        PieChartDataPoint(value: Double(ticketsNotDone), description: "Completed",   colour: .green   , label: .icon(systemName: "2.square", colour: .white, size: 30)),
                        PieChartDataPoint(value: Double(ticketsPriority), description: "Not Done", colour: .red, label: .icon(systemName: "3.square", colour: .white, size: 30)),
                        
                    ],
                    legendTitle: "Data"),
                                             metadata: ChartMetadata(title: "Tasks", subtitle: "Dev Bandwidth"),
                                             chartStyle: PieChartStyle(infoBoxPlacement: .header)))
            })
            
            .toolbar {
                Button("Add") {
                    isSheetPresented.toggle()
                }
                Spacer()
                Button("Dashboard"){
                    isDashboardPresented.toggle()
                }
            }
        }
    }
    private func increment(key : String){
        
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            self.viewContext.delete(todo)
            do {
                try viewContext.save()
                print("perform delete")
            } catch {
                // handle the Core Data error
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
