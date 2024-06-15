//
//  TodoDetailView.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//

import SwiftUI

struct TodoDetailView: View {
    @State var isShowingEditForm: Bool = false
    
    var todo: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(todo.title ?? "")
                    .font(.title)
                Spacer()
                Text(todo.priority ?? Priority.low.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
           
            Text(formatDate(todo.date ?? Date()))
                .font(.subheadline)
                .foregroundColor(.gray)
           
            StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
        }
        .padding()
        .navigationTitle("Todo Details")
        .toolbar {
            Button("Edit") {
                isShowingEditForm.toggle()
            }
        }
        .sheet(isPresented: $isShowingEditForm) {
            TodoInputForm(todo: todo, isPresented: $isShowingEditForm)
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
